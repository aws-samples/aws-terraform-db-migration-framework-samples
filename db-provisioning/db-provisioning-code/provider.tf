provider "aws" {
  region = "us-east-2"
}

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

locals {
  common_tags = {
    Owner   = "DevOps"
    Project = var.project_code
  }
}
