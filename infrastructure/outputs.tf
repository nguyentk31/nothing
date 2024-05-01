# Main
output "aws_region" {
  value       = var.aws_region
  description = "AWS Region"
}

# Outputs of EKS module
output "cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS Cluster's name"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS Cluster's endpoint"
}

output "cluster_ca" {
  value       = module.eks.cluster_ca
  description = "EKS Cluster's CA Certificate"
}

# Outputs of LBC module
output "lbc_sa" {
  value       = var.lbc_sa
  description = "Service Account's Name for LBC"
}

output "lbc_namespace" {
  value       = var.lbc_namespace
  description = "EKS Namespace to deploy LBC"
}

output "lbc_role" {
  value       = module.lbc.lbc_role
  description = "LBC Role (ARN)"
}

output "alb_sg" {
  value       = module.lbc.alb_sg
  description = "ALB's security group ID"
}

# Outputs of ECR module
output "image_ecr_url" {
  value       = module.ecr.image_ecr_url
  description = "Image ECR's URL"
}

output "chart_ecr_url" {
  value       = module.ecr.chart_ecr_url
  description = "Chart ECR's URL"
}

output "github_actions_role" {
  value       = module.ecr.github_actions_role
  description = "Github actions role (ARN)"
}
