# Configure the AWS Provider
terraform {

  backend "local" {}

  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
      version = "3.37.0"
    }
  }
}

provider "aws" {
  region = local.default_region
}