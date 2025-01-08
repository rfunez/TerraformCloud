terraform {
  required_version = ">1.10.0"
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
}
