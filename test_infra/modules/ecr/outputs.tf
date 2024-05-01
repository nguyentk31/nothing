output "image_ecr_url" {
  value       = aws_ecr_repository.image.repository_url
  description = "Image ECR's URL"
}

output "chart_ecr_url" {
  value       = aws_ecr_repository.chart.repository_url
  description = "Chart ECR's URL"
}

output "github_actions_role" {
  value       = aws_iam_role.github-actions.arn
  description = "Github actions role (ARN)"
}
