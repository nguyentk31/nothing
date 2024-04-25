# Main variables
variable "project" {
  type        = string
  description = "Project's name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

# VPC module's variables
variable "vpc_config" {
  type = object({
    cidr_block                    = optional(string, "10.0.0.0/16"), # Number of Availability Zones (AZs)
    enable_dns_support            = optional(bool, true),            # whether enable dns support in vpc or not
    enable_dns_hostnames          = optional(bool, true),            # whether enable dns hostnames in vpc or not
    number_availability_zones     = optional(number, 3),             # Number of Availability Zones (AZs)
    number_public_subnets_per_az  = optional(number, 1),             # Number of Availability Zones (AZs)
    number_private_subnets_per_az = optional(number, 1),             # Number of Availability Zones (AZs)
    number_nat_gateway            = optional(number, 1),             # Number of Nat Gateway
  })

  validation {
    condition     = var.vpc_config.number_nat_gateway <= var.vpc_config.number_availability_zones * var.vpc_config.number_public_subnets_per_az
    error_message = "Number of nat gateway is too large"
  }
}

# IAM module's variables
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

# EKS module's variables
variable "k8s_version" {
  type        = string
  default     = "1.29"
  description = "Kubernetes version"
}


variable "service_ipv4_cidr" {
  type        = string
  default     = "172.20.0.0/16"
  description = "The CIDR block to assign Kubernetes pod and service IP addresses from"
}

