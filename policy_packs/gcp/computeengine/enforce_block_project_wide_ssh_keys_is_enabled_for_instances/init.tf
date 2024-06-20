terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Enable Block Project-Wide SSH Keys for GCP Compute Engine Instances"
  description = "Restrict the use of universally accessible SSH keys, thereby reducing the risk of unauthorized access."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Compute Engine > Enabled
resource "turbot_policy_setting" "gcp_compute_engine_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/computeEngineEnabled"
  value    = "Enabled"
}
