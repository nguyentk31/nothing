output "subnet_id" {
  value = aws_subnet.uit.id
}

# Application's outputs
output "chart_version" {
  value = var.chart_version
}

output "image_tag" {
  value = var.image_tag
}