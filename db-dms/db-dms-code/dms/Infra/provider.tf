provider "aws" {
  region                  = "us-east-2"
  default_tags {
    tags = {
      CreatedBy = "Someone"
    }
  }
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}
