terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.48.0" # Terraform AWS provider version
    }
  }
backend "s3" {
  bucket = "docker1-remote-state"
  key = "expense-infra-dev-frontend"
  region = "us-east-1"
  dynamodb_table = "docker1-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
  
}