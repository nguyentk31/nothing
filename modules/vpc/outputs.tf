output "vpc" {
  value       = aws_vpc.vpc.id
  description = "VPC id"
}

output "public_subnets" {
  value       = aws_subnet.public-subnets[*].id
  description = "Public subnets id"
}

output "private_subnets" {
  value       = aws_subnet.private-subnets[*].id
  description = "Private subnets id"
}