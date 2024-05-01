/*
*/
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

# Outputs of ECR Repository
output "image_ecr_url" {
  value       = aws_ecr_repository.image.repository_url
  description = "Image ECR's URL"
}

output "chart_ecr_url" {
  value       = aws_ecr_repository.chart.repository_url
  description = "Chart ECR's URL"
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

output "alb_sg" {
  value = module.lbc.alb_sg
  description = "ALB's security group ID"
}
