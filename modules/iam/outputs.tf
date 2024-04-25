output "eks_cluster_roles" {
  value       = { for role in aws_iam_role.eks-cluster-roles : role.tags.Role => role.arn }
  description = "Map of EKS cluster role (name, arn)"
}

output "eks_master_role" {
  value       = aws_iam_role.eks-master-role.arn
  description = "EKS master role (ARN)"
}

output "attachments_role" {
  value       = aws_iam_role_policy_attachment.eks-policy-attachments[*]
  description = "List of EKS policy attachments"
}