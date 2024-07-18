terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  profile = "Parker"
}
