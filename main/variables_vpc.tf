variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "number_availability_zones" {
  type    = number
  default = 3
}

variable "number_public_subnets_per_az" {
  type    = number
  default = 1
}

variable "number_private_subnets_per_az" {
  type    = number
  default = 1
}


variable "number_nat_gateways" {
  type    = number
  default = 1
}