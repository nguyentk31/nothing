# Main variables
project     = "TMP"
environment = "development"
aws_region  = "us-west-2"

# VPC module's variables
vpc_config = {
  cidr_block                    = "10.10.0.0/16"
  enable_dns_support            = true
  enable_dns_hostnames          = true
  number_availability_zones     = 3
  number_public_subnets_per_az  = 1
  number_private_subnets_per_az = 2
  number_nat_gateway            = 1
}

# IAM module's variables
# github_account_id = "992382851936" # Github-actions user id
github_account_id = "637423337672" # Learner-lab

eks_cluster_roles = {
  EKSClusterRole = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  }
  EKSNodeGroupRole = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  }
  EKSPodRole = {
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole", "sts:TagSession"]
        Effect = "Allow"
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  }
}

eks_policy_attachments = [
  {
    role_name  = "EKSClusterRole"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  },
  {
    role_name  = "EKSNodeGroupRole"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  },
  {
    role_name  = "EKSNodeGroupRole"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  },
  {
    role_name  = "EKSPodRole"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  },
]

# EKS module's variables
k8s_version       = "1.28"
service_ipv4_cidr = "172.10.0.0/16"