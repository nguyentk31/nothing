output "lbc_role" {
  value       = aws_iam_role.lbc
  description = "LBC Role (ARN)"
}

output "alb_sg" {
  value       = aws_security_group.alb.id
  description = "ALB's security group ID"
}