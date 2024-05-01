# EKS cluster role (assume role policy, policy attachment)
resource "aws_iam_role" "eks-cluster" {
  name               = "${var.default_tags.Project}-${var.default_tags.Environment}-EKSClusterRole"
  assume_role_policy = file("./policies/EKSClusterAssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "EKSCluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

# EKS node group role (assume role policy, policy attachment)
resource "aws_iam_role" "eks-nodegroup" {
  name               = "${var.default_tags.Project}-${var.default_tags.Environment}-EKSNodeGroupRole"
  assume_role_policy = file("./policies/EKSNodeGroupAssumeRolePolicy.json")
}

resource "aws_iam_role_policy_attachment" "EKSNodeGroup-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-nodegroup.name
}
resource "aws_iam_role_policy_attachment" "EKSNodeGroup-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-nodegroup.name
}
resource "aws_iam_role_policy_attachment" "EKSNodeGroup-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-nodegroup.name
}

# EKS master role 
resource "aws_iam_role" "eks-master" {
  name               = "${var.default_tags.Project}-${var.default_tags.Environment}-EKSMasterRole"
  assume_role_policy = file("./policies/EKSMasterAssumeRolePolicy.json")
}

resource "aws_iam_policy" "eks-master" {
  name        = "${var.default_tags.Project}-${var.default_tags.Environment}-EKSMasterPolicy"
  path        = "/"
  description = "EKS Master policy"
  policy      = file("./policies/EKSMasterPolicy.json")
}

resource "aws_iam_role_policy_attachment" "EKSMasterPolicy" {
  policy_arn = aws_iam_policy.eks-master.arn
  role       = aws_iam_role.eks-master.name
}

# Cluster Certificate and OIDC
data "tls_certificate" "cluster-cert" {
  url = aws_eks_cluster.uit.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc-provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cluster-cert.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.cluster-cert.url
}