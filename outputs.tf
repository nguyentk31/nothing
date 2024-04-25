# # Outputs of VPC module
# output "vpc" {
#   value       = module.vpc.vpc
#   description = "VPC id"
# }

# output "public_subnets" {
#   value       = module.vpc.public_subnets
#   description = "Public subnets id"
# }

# output "private_subnets" {
#   value       = module.vpc.private_subnets
#   description = "Private subnets id"
# }

# Outputs of IAM module
output "eks_cluster_roles" {
  value       = module.iam.eks_cluster_roles
  description = "Map of EKS cluster role (name, arn)"
}

output "eks_master_role" {
  value       = module.iam.eks_master_role
  description = "EKS master role (ARN)"
}

output "attachments_role" {
  value       = module.iam.attachments_role
  description = "List of EKS policy attachments"
}