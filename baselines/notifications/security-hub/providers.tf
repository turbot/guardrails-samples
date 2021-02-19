
terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.13"
}

provider "turbot" {
  profile = var.turbot_profile
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
