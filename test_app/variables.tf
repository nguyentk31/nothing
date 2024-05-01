variable "subnet_name" {
  type = string
}

variable "vpc_id" {
  type = string
  default = "nothing"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

# ECR URL
variable "image_ecr_url" {
  type        = string
  default = "nothing-url"
  description = "Image ECR's URL"
}

variable "chart_ecr_url" {
  type        = string
  default = "nothing-url"
  description = "Chart ECR's URL"
}

# Application's variables
variable "chart_version" {
  type        = string
  default     = "latest"
  description = "Helm chart name"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Application image's tag"
}