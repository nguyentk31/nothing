terraform {
  # cloud config by env
  cloud {
    organization = "nguyentk-101"
    workspaces {
      project = "prj-101"
      name = "101"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "my-role" {
  name = "testing-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          AWS = data.aws_caller_identity.current.account_id
        }
      }
    ]
  })
}

output "my_role" {
  value = aws_iam_role.my-role.arn
}