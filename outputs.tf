# Outputs of VPC module
output "vpc" {
  value       = module.vpc.vpc
  description = "VPC id"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "Public subnets id"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "Private subnets id"
}