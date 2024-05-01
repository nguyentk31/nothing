# VPC 
output "vpc_id" {
  value       = aws_vpc.uit.id
  description = "VPC id"
}

# Public subnets
output "public_subnets" {
  value       = aws_subnet.publics[*].id
  description = "Public subnets id"
}

# Private subnets
output "private_subnets" {
  value       = aws_subnet.privates[*].id
  description = "Private subnets id"
}