terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.12"

  backend "s3" {
    bucket = "tf-workshop-m6"
    key = "workshop_1"
    region = "eu-west-3"
  }
}
