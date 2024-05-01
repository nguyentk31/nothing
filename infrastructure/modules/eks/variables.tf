variable "default_tags" {
  type        = map(string)
  description = "Project's default tags"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
}

variable "eks_addons" {
  type        = list(string)
  description = "List of EKS addons"
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
