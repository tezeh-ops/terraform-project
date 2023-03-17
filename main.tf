locals {
  # Default tags to be applied to all compatible resources
  default_tags = {
    "OwnedBy" = "Terraform",
    "cost-center" = "data-sharing",
    "source" = "git@gitlab.com:{github-username}/{repository-name}.git"
  }

  aws_profile = "aws"
  aws_region = "us-east-1"

  project_name = "terra-backend"

  github_username = "tezeh-ops"
}

resource "aws_kms_key" "terrakey" {
  description = "s3 backend key"
  deletion_window_in_days = 30
}

resource "aws_s3_bucket" "bootcamp30-23-samueltech" {
  bucket = "bootcamp30-23-samueltech"
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.terrakey.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_dynamodb_table" "dynamodb-table" {
  hash_key = "LockID"
  name     = "iac-terraform-states-lock"
  write_capacity = 5
  read_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
}
                                                    
terraform {               #  Configure Terraform to point to this backend        
  backend "s3" {
    bucket         = "bootcamp30-23-samueltech"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "iac-terraform-states-lock"
  }
}

resource "aws_instance" "my_demo_ec2" {
  ami           = "ami-0c9978668f8d55984" # us-west-2
  instance_type = "t2.micro"
  tags = {
    "Name" = "my_ec2"
  }
}