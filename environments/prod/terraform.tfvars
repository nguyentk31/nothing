# Main variables
project     = "TMP"
environment = "production"
aws_region  = "us-east-1"

# VPC module's variables
vpc_config = {
  cidr_block                    = "10.1.0.0/16"
  enable_dns_support            = true
  enable_dns_hostnames          = true
  number_availability_zones     = 2
  number_public_subnets_per_az  = 1
  number_private_subnets_per_az = 1
}