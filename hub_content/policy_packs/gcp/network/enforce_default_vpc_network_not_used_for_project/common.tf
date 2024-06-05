# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce default VPC network is not used within GCP projects"
  description = "Ensure that the default VPC network is not being used within GCP projects."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Network > Enabled
resource "turbot_policy_setting" "gcp_network_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkEnabled"
  value    = "Enabled"
}
