variable "project" {
  type        = string
  description = "Project's name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "vpc_cidr" {
  type        = string
  description = "IPv4 CIDR block for VPC should have prefix be 16 (16)"
}

variable "number_availability_zones" {
  type        = number
  description = "Number of Availability Zones (AZs)"
  validation {
    condition     = var.number_availability_zones <= data.aws_availability_zones.azs && var.number_availability_zones <= 3
    error_message = "Number of AZs is too large"
  }
}

variable "number_public_subnets_per_az" {
  type        = number
  description = "Number of Public Subnets per AZ"
  validation {
    condition     = var.number_public_subnets_per_az < 2
    error_message = "Number of Public Subnets is too large"
  }
}

variable "number_private_subnets_per_az" {
  type        = number
  description = "Number of Private Subnets per AZ"
  validation {
    condition     = var.number_private_subnets_per_az < 3
    error_message = "Number of Private Subnets is too large"
  }
}


variable "number_nat_gateways" {
  type = number
  validation {
    condition     = var.number_nat_gateways <= var.number_public_subnets_per_az * data.aws_availability_zones.azs
    error_message = "Number of Nat Gateways is too large"
  }
  description = "Number of Nat Gateways"
}