variable "project" {
  type        = string
  description = "Project's name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "github_account_id" {
  type        = string
  description = "Github Actions account's ID"
}

variable "eks_cluster_roles" {
  type = map(object({
    Version = string,
    Statement = list(object({
      Action    = list(string),
      Effect    = string,
      Principal = map(string)
    }))
  }))
  description = "Map of EKS cluster roles (name, trusted entities)"
}

variable "eks_policy_attachments" {
  type        = list(map(string))
  description = "List of EKS policy attachments"
}
