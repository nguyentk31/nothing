output "alb_sg" {
  value = aws_security_group.alb.id
  description = "ALB's security group ID"
}