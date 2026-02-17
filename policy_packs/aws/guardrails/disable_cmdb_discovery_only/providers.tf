terraform {
  required_providers {
    turbot = {
      source  = "turbot/turbot"
      version = ">=1.10.0"
    }
  }
}

provider "turbot" {
  profile = var.turbot_profile
}
