terraform {
  required_version = ">1.9.5"
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
  alias = "espana"
  profile = "aws"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "random" {
  alias = "random"
}