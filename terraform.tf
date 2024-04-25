terraform {
  # cloud config
  cloud {
    organization = "ogn-tmp"
    workspaces {
      project = "prj-tmp"
    }
  }

  # provider config
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}