terraform {
  # cloud config
  cloud {}

  # provider config
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.13.1"
    }
  }
}