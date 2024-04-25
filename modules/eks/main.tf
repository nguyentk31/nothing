// EKS CLUSTER
resource "aws_eks_cluster" "cluster" {
  name     = "${var.project}-${var.environment}-EKSCluster"
  role_arn = var.eks_cluster_roles.cluster
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

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

// EKS NODE GROUP
resource "aws_eks_node_group" "nodegroup" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.project}-${var.environment}-EKSNodegroup"
  node_role_arn   = var.eks_cluster_roles.nodegroup
  subnet_ids      = var.node_group_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size] // Ignore desired size 
  }

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

// EKS masters access entry and policy association
resource "aws_eks_access_entry" "master-access_entry" {
  cluster_name  = aws_eks_cluster.cluster.name
  principal_arn = var.eks_master_role
  user_name     = "${var.project}-${var.environment}-Master"

  tags = {
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_eks_access_policy_association" "master-policy-association" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.eks_master_role

  access_scope {
    type = "cluster"
  }
}
