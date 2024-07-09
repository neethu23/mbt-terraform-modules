terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
      backend "s3" {
      bucket = "demo-statefile-s3"
      key    = "terraform-state-modules.tfstate"
      region = "us-east-2"
    }
   
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  #profile = "Neethu"
}