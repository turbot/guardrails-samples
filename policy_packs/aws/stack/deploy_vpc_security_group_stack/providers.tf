terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
    # aws = {
    #   source  = "terraform-providers/aws"
    #   version = "5.72.0"
    # }
  }
}

provider "turbot" {
  profile = "punisher"
}

provider "aws" {
  profile = "punisher"
  region  = "us-east-1"
}
