# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce enable block project-wide SSH keys for GCP Compute Engine instances"
  description = "Enforce enable block project-wide SSH keys for GCP Compute Engine instances"
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Compute Engine > Enabled
resource "turbot_policy_setting" "gcp_compute_engine_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/computeEngineEnabled"
  value    = "Enabled"
}
