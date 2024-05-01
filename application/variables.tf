# Main variables
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

# EKS Variables
variable "cluster_name" {
  type        = string
  description = "EKS Cluster's name"
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS Cluster's endpoint"
}

variable "cluster_ca" {
  type        = string
  description = "EKS Cluster's CA Certificate"
}

# LBC variables
variable "lbc_sa" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "Service Account's Name for LBC"
}

variable "lbc_namespace" {
  type        = string
  default     = "kube-system"
  description = "EKS Namespace to deploy LBC"
}

variable "lbc_role" {
  type        = string
  description = "AWS LBCr Role (ARN)"
}

variable "alb_sg" {
  type        = string
  description = "ALB security group id"
}

# ECR URL
variable "image_ecr_url" {
  type        = string
  description = "Image ECR's URL"
}

variable "chart_ecr_url" {
  type        = string
  description = "Chart ECR's URL"
}

# Application's variables
variable "chart_version" {
  type        = string
  default     = "my-application"
  description = "Helm chart name"
}

variable "image_tag" {
  type        = string
  description = "Application image's tag"
}