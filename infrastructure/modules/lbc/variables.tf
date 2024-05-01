variable "default_tags" {
  type        = map(string)
  description = "Project's default tags"
}

variable "oidc_provider_url" {
  type        = string
  description = "IAM OpenID Connect provider's URL"
}

variable "oidc_provider_arn" {
  type        = string
  description = "IAM OpenID Connect provider's ARN"
}

variable "lbc_sa" {
  type        = string
  description = "Service Account's Name for LBC"
}

variable "lbc_namespace" {
  type        = string
  description = "EKS Namespace to deploy LBC"
}

variable "cluster_vpc" {
  type        = string
  description = "EKS Cluster VPC to deploy ALB (VPC id)"
}