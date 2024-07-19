terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }
  backend "s3" {
    bucket = "softdesign-challenge-tf-state"
    key    = "softdesign-challenge.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

