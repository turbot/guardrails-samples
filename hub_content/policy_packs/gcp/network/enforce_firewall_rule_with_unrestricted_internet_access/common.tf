# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce VPC firewall with unrestricted inbound access"
  description = "Ensure that there are no VPC firewall rules that allow unrestricted inbound access on known ports."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Network > Enabled
resource "turbot_policy_setting" "gcp_network_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkServiceEnabled"
  value    = "Enabled"
}
