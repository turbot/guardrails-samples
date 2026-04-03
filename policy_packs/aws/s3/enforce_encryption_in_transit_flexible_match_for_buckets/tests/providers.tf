terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    turbot = {
      source  = "turbot/turbot"
      version = ">= 1.11.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "turbot" {
}
