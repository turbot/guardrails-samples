terraform {
  required_providers {
    turbot = {
      source = "terraform-providers/turbot"
    }
  }

  required_version = ">= 0.13"
}

provider "turbot" {
  profile = var.turbot_profile
}
