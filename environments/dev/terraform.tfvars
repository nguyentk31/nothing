# Main variables
project     = "TMP"
environment = "development"
aws_region  = "us-west-2"

# VPC module's variables
vpc_config = {
  cidr_block                    = "10.10.0.0/16"
  enable_dns_support            = true
  enable_dns_hostnames          = true
  number_availability_zones     = 3
  number_public_subnets_per_az  = 2
  number_private_subnets_per_az = 2
}