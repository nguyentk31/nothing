provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  project                       = var.project
  environment                   = var.environment
  vpc_cidr                      = var.vpc_config.cidr_block
  enable_dns_hostnames          = var.vpc_config.enable_dns_support
  enable_dns_support            = var.vpc_config.enable_dns_hostnames
  number_availability_zones     = var.vpc_config.number_availability_zones
  number_public_subnets_per_az  = var.vpc_config.number_public_subnets_per_az
  number_private_subnets_per_az = var.vpc_config.number_private_subnets_per_az
  number_nat_gateway            = var.vpc_config.number_nat_gateway
}