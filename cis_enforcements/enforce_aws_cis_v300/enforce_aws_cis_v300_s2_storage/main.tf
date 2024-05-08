terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  profile = var.guardrails_profile
}

variable "guardrails_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

