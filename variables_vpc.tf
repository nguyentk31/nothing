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