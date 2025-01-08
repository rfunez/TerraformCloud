terraform {
  required_version = ">1.9.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=5.76.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "eu-south-2"
  secret_key = var.aws_secret_access_key
  access_key = var.aws_access_key_id
}

provider "random" {
}

