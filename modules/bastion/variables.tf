variable "project" {
  type        = string
  description = "Project's name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "number_bastion_hosts" {
  type        = number
  description = "Number of Bastion Hosts"
  validation {
    condition     = var.number_bastion_hosts <= 3
    error_message = "Number of Bastion Hosts is too large"
  }
}

variable "instance_type" {
  type        = string
  description = "Bastion Host instance type"
}

variable "ssh_pubkey" {
  type        = string
  description = "Public SSH key of bastion hosts"
}