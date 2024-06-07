# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Ensure VM is created by using image from trusted publisher only"
  description = "Ensure that the VM is created by using image from trusted publisher only."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > Compute > Enabled
resource "turbot_policy_setting" "azure_compute_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/computeEnabled"
  value    = "Enabled"
}
