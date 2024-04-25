# EKS cluster roles
resource "aws_iam_role" "eks-cluster-roles" {
  for_each           = var.eks_cluster_roles
  name               = "${var.project}-${var.environment}-${each.key}"
  assume_role_policy = jsonencode(each.value)

  tags = {
    Role        = each.key
    Project     = var.project
    Environment = var.environment
  }
}

# EKS policy attachments
resource "aws_iam_role_policy_attachment" "eks-policy-attachments" {
  count      = length(var.eks_policy_attachments)
  policy_arn = var.eks_policy_attachments[count.index].policy_arn
  role       = "${var.project}-${var.environment}-${var.eks_policy_attachments[count.index].role_name}"
  depends_on = [aws_iam_role.eks-cluster-roles]
}

// EKS master role 
resource "aws_iam_role" "eks-master-role" {
  name = "${var.project}-${var.environment}-MasterRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = var.github_account_id
        }
      }
    ]
  })

  tags = {
    Role        = "MasterRole"
    Project     = var.project
    Environment = var.environment
  }
}
