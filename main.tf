terraform {
  required_version = ">= 0.12"

  required_providers {
      aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}