output "cluster_name" {
  value       = aws_eks_cluster.uit.name
  description = "EKS cluster's name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.uit.endpoint
  description = "EKS cluster's endpoint"
}

output "cluster_ca" {
  value       = aws_eks_cluster.uit.certificate_authority[0].data
  description = "EKS cluster's CA Certificate"
}