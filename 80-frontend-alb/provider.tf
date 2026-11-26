terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 6.0.0"
    }
  }
  backend "s3" {
    bucket = "roboshop-dev-remote-state09"
    region = "us-east-1"
    encrypt = true 
    key = "roboshop-dev-frontend-lb.tfstate"
    use_lockfile = true 
  }

}

# configure the aws provider

provider "aws" {
  region = "us-east-1"
}