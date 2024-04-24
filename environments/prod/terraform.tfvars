# Main variables
project     = "TMP"
environment = "production"
aws_region  = "us-west-1"

# VPC module's variables
vpc_cidr                      = "10.10.0.0/16"
number_availability_zones     = 2
number_public_subnets_per_az  = 1
number_private_subnets_per_az = 1
number_nat_gateways           = 1