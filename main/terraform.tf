terraform {
  required_version = "1.8.1"

  # cloud config
  cloud {
    organization = "ogn-tmp"
    workspaces {
      project = "prj-tmp"
      name    = "ws-tmp"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}