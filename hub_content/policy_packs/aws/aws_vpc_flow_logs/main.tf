terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

variable "policy_pack_title" {
  type        = string
  description = "Title for the policy pack"
}
