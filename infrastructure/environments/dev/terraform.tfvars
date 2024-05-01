# Main variables
project     = "myprj"
environment = "dev"
aws_region  = "us-east-1"

# VPC module's variables
vpc_config = {
  cidr_block                    = "10.0.0.0/16"
  enable_dns_support            = true
  enable_dns_hostnames          = true
  number_availability_zones     = 2
  number_public_subnets_per_az  = 1
  number_private_subnets_per_az = 1
  number_nat_gateway            = 1
}

# EKS module's variables
k8s_version       = "1.29"
eks_addons        = ["vpc-cni", "coredns", "kube-proxy", "eks-pod-identity-agent"]
service_ipv4_cidr = "10.10.0.0/16"

# LBC module's variables
lbc_sa = "aws-load-balancer-controller"
lbc_namespace = "kube-system"

# ECR module's variables
github_account_id = "992382851936"
