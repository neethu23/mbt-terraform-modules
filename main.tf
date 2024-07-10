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

module "vpc"{
    source = "./modules/vpc"
    cidr_block = var.cidr_block
    name = var.name
    cidr_block_subnet_1 = var.cidr_block_subnet_1 
    cidr_block_subnet_2 = var.cidr_block_subnet_2
    cidr_block_subnet_3 = var.cidr_block_subnet_3
    cidr_block_subnet_4 = var.cidr_block_subnet_4
    az_1 = var.az_1
    az_2 = var.az_2


}

module "sg"{
    source = "./modules/sg"
    vpc_id = module.vpc.id
        
        
    }


# module "instance"{
#     source = "./modules/ec2"

# }



