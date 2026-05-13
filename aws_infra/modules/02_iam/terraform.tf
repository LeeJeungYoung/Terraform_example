

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "aws03-terraform-state-bucket"
    key            = "iam/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "aws03-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

