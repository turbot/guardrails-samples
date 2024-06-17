# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP VPC Network Firewall Rules With Range Of Ports To Not Allow Incoming Traffic"
  description = "Delete GCP VPC network firewall rules with range of ports that are opened to allow incoming traffic."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Network > Enabled
resource "turbot_policy_setting" "gcp_network_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkServiceEnabled"
  value    = "Enabled"
}
