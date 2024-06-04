# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect if Azure network security group rules allow all, RDP and SSH inbound access"
  description = "Detect if AWS EC2 instance has IMDSv2 enforced"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > Network > Enabled
resource "turbot_policy_setting" "azure_network_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkEnabled"
  value    = "Enabled"
}
