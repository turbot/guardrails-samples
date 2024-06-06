# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect that load balancers enforce HTTPS to handle encrypted web traffic"
  description = "Detect if GCP Network load balancer enforce HTTPS to handle encrypted web traffic."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Network > Enabled
resource "turbot_policy_setting" "gcp_network_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkEnabled"
  value    = "Enabled"
}