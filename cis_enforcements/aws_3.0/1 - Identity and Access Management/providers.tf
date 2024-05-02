terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
      version = ">= 1.10.1"
    }
  }
  
  required_version = ">= 0.15"

}

provider "turbot" {
  profile = var.turbot_profile
}
