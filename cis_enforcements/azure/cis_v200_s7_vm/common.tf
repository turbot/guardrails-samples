# Smart Folder
resource "turbot_smart_folder" "azure_cis_v200_s7_virtual_machine" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 7 - Virtual Machines"
  description = "This section contains recommendations for configuring Azure virtual machines."
}

# Azure > Compute > Enabled
resource "turbot_policy_setting" "azure_compute_enabled" {
  resource = turbot_smart_folder.azure_cis_v200_s7_virtual_machine.id
  type     = "tmod:@turbot/azure-compute#/policy/types/computeEnabled"
  value    = "Enabled"
}
