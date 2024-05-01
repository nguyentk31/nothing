terraform {
  # cloud config
  cloud {}

  # provider config
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_subnet" "uit" {
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 5, 0)

  tags = {
    Name                     = "${var.vpc_id}-${var.subnet_name}"
    image_tag = var.image_tag
    chart_version = var.chart_version
    image_ecr_url = var.image_ecr_url
    chart_ecr_url = var.chart_ecr_url
  }
}