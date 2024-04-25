variable "project" {
  type        = string
  description = "Project's name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "eks_cluster_roles" {
  type        = map(string)
  description = "Map of EKS cluster role (name, arn)"
}

variable "eks_master_role" {
  type        = string
  description = "EKS masters role (ARN)"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
}

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "Subnets where EKS control plane place ENI"
}

variable "service_ipv4_cidr" {
  type        = string
  description = "The CIDR block to assign Kubernetes pod and service IP addresses from"
}

variable "node_group_subnet_ids" {
  type        = list(string)
  description = "Subnets where node group be placed"
}