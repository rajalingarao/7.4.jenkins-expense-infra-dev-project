terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0" # Terraform AWS provider version
    }
  }
backend "s3" {
  bucket = "docker1-remote-state"
  key = "infra-jenkins-vpc"
  region = "us-east-1"
  dynamodb_table = "docker1-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
  
}
