output "aws_region" {
  value = var.aws_region
}

output "vpc_id" {
  value = aws_vpc.uit.id
}

output "vpc_cidr" {
  value = aws_vpc.uit.cidr_block
}

output "vpc_name" {
  value = aws_vpc.uit.tags.Name
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