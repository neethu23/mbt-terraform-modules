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
    vpc_id = module.vpc.vpc_id
        
        
    }


module "asg"{
    source = "./modules/asg"
    name = var.name
    ami = var.ami
    instance_type = var.instance_type
    demo_key_name = var.demo_key_name
    demo_key_value = var.demo_key_value
    subnet_public_2a_id = module.vpc.subnet_public_2a_id
    subnet_public_2b_id = module.vpc.subnet_public_2b_id
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size
    target_group_arn = module.alb.target_group_arn
    sg_22_id = module.sg.sg_22_id
    sg_80_id = module.sg.sg_80_id
    

}

module "alb"{
    source = "./modules/alb"
    name = var.name
    vpc_id = module.vpc.vpc_id
    subnet_public_2a_id = module.vpc.subnet_public_2a_id
    subnet_public_2b_id = module.vpc.subnet_public_2b_id
    Environment = var.Environment
    sg_80_id = module.sg.sg_80_id
        
        
    }

# module "instance"{
#     source = "./modules/ec2"
#     ami = var.ami
#     instance_type = var.instance_type
    

# }



