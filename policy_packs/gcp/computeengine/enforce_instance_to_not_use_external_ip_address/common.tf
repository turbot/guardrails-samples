# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP Compute Engine Instances to Not Use External IP Addresses"
  description = "Delete access configs for GCP Compute Engine instances that use external IP addresses."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Compute Engine > Enabled
resource "turbot_policy_setting" "gcp_compute_engine_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/computeEngineEnabled"
  value    = "Enabled"
}
