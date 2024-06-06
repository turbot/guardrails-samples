# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce approved VM extension installed"
  description = "Stop VM that uses unapproved VM extention"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > Compute > Enabled
resource "turbot_policy_setting" "azure_compute_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/computeEnabled"
  value    = "Enabled"
}
