terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "clouddevops-bucket-s3"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "clouddevops-table"
  }
}