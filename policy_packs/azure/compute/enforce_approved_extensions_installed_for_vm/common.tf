# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Approved Extensions Are Installed on Azure Compute Virtual Machines"
  description = "Stop/Terminate Azure compute virtual machines use unapproved extensions."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > Compute > Enabled
resource "turbot_policy_setting" "azure_compute_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/computeEnabled"
  value    = "Enabled"
}
