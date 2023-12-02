terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.29.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "kms" {
    source = "./modules/kms"
}


resource "aws_instance" "ec2-instance-tf" {
    instance_type = "t2.micro"
    ami = "ami-023c11a32b0207432"
    tags = {
        Name = "aws-instance-unencrypted"
    }
    root_block_device {
      delete_on_termination = false
      tags = {
        Name = "root-unencrypted"
      }
      volume_size = "10"
      encrypted = true
      kms_key_id = module.kms.aws_kms_key
    }
    ebs_block_device {
      device_name = "/dev/sdf"
      delete_on_termination = false
      tags = {
        Name = "ebs-unencrypted"
      }
      volume_size = "10"
      encrypted = true
      kms_key_id = module.kms.aws_kms_key
    }
}

