variable "default_tags" {
  type        = map(string)
  description = "Project's default tags"
}

variable "cluster_vpc" {
  type        = string
  description = "EKS Cluster VPC to deploy ALB (VPC id)" 
}