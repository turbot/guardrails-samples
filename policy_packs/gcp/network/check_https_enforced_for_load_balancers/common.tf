# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Check If GCP Network Load Balancers Enforce HTTPS to Manage Encrypted Web Traffic"
  description = "Detect if GCP Network load balancers enforce HTTPS to handle encrypted web traffic."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Network > Enabled
resource "turbot_policy_setting" "gcp_network_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkServiceEnabled"
  value    = "Enabled"
}