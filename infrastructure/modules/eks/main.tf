# EKS CLUSTER
resource "aws_eks_cluster" "uit" {
  name     = "${var.default_tags.Project}-${var.default_tags.Environment}-EKSCluster"
  role_arn = "arn:aws:iam::637423337672:role/LabRole"
  version  = var.k8s_version

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    endpoint_public_access  = true
    endpoint_private_access = true
    subnet_ids              = var.cluster_subnet_ids
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
  }
}

resource "aws_eks_addon" "uit" {
  count        = length(var.eks_addons)
  cluster_name = aws_eks_cluster.uit.name
  addon_name   = var.eks_addons[count.index]

  depends_on = [aws_eks_node_group.uit]
}

// EKS NODE GROUP
resource "aws_eks_node_group" "uit" {
  node_group_name = "${var.default_tags.Project}-${var.default_tags.Environment}-EKSNodegroup"
  cluster_name    = aws_eks_cluster.uit.name
  node_role_arn   = "arn:aws:iam::637423337672:role/LabRole"
  subnet_ids      = var.node_group_subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size] // Ignore desired size 
  }
}