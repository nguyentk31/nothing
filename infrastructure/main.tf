provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
    }
  }
}

data "aws_default_tags" "uit" {}

# Module VPC
module "vpc" {
  source = "./modules/vpc"

  default_tags                  = data.aws_default_tags.uit.tags
  vpc_cidr                      = var.vpc_config.cidr_block
  enable_dns_hostnames          = var.vpc_config.enable_dns_support
  enable_dns_support            = var.vpc_config.enable_dns_hostnames
  number_availability_zones     = var.vpc_config.number_availability_zones
  number_public_subnets_per_az  = var.vpc_config.number_public_subnets_per_az
  number_private_subnets_per_az = var.vpc_config.number_private_subnets_per_az
  number_nat_gateways           = var.vpc_config.number_nat_gateways
}

# Module EKS
module "eks" {
  source = "./modules/eks"

  default_tags          = data.aws_default_tags.uit.tags
  k8s_version           = var.k8s_version
  eks_addons            = var.eks_addons
  cluster_subnet_ids    = module.vpc.public_subnets
  service_ipv4_cidr     = var.service_ipv4_cidr
  node_group_subnet_ids = module.vpc.private_subnets
}

# Module LBC
module "lbc" {
  source = "./modules/lbc"

  default_tags      = data.aws_default_tags.uit.tags
  oidc_provider_url = module.eks.oidc_provider_url
  oidc_provider_arn = module.eks.oidc_provider_arn
  lbc_sa            = var.lbc_sa
  lbc_namespace     = var.lbc_namespace
  cluster_vpc       = module.vpc.vpc_id
}

# Module ECR
module "ecr" {
  source = "./modules/ecr"

  default_tags      = data.aws_default_tags.uit.tags
  github_account_id = var.github_account_id
}
