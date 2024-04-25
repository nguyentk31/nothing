provider "aws" {
  region = var.aws_region
}

# module "vpc" {
#   source = "./modules/vpc"

#   project                       = var.project
#   environment                   = var.environment
#   vpc_cidr                      = var.vpc_config.cidr_block
#   enable_dns_hostnames          = var.vpc_config.enable_dns_support
#   enable_dns_support            = var.vpc_config.enable_dns_hostnames
#   number_availability_zones     = var.vpc_config.number_availability_zones
#   number_public_subnets_per_az  = var.vpc_config.number_public_subnets_per_az
#   number_private_subnets_per_az = var.vpc_config.number_private_subnets_per_az
#   number_nat_gateway            = var.vpc_config.number_nat_gateway
# }

module "iam" {
  source = "./modules/iam"

  project                = var.project
  environment            = var.environment
  github_account_id      = var.github_account_id
  eks_cluster_roles      = var.eks_cluster_roles
  eks_policy_attachments = var.eks_policy_attachments
}

# module "eks" {
#   source = "./modules/eks"

#   project               = var.project
#   environment           = var.environment
#   eks_cluster_roles     = module.iam.eks_cluster_roles
#   eks_master_role       = module.iam.eks_master_role
#   k8s_version           = var.k8s_version
#   cluster_subnet_ids    = module.vpc.public_subnets
#   service_ipv4_cidr     = var.service_ipv4_cidr
#   node_group_subnet_ids = module.vpc.private_subnets

#   depends_on = module.iam.eks_policy_attachments
# }