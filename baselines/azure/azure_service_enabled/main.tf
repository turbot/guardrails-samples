# Create Smart Folder
resource "turbot_policy_pack" "azure_enabled_baseline_pack" {
  parent = "tmod:@turbot/turbot#/"
  title  = "Azure Enabled Baseline Policies"
}

# Enable Provider
resource "turbot_policy_setting" "provider_registration_enable" {
  count    = length(var.provider_status)
  resource = turbot_policy_pack.azure_enabled_baseline_pack.id
  type     = "tmod:@turbot/azure-provider#/policy/types/${lookup(var.provider_registration_map, "${element(keys(var.provider_status), count.index)}")}"
  value    = lookup(var.provider_status, "${element(keys(var.provider_status), count.index)}")
}

# Enable Service
# Loop through var.service_status and set enable policies
resource "turbot_policy_setting" "azure_enable" {
  for_each = var.enabled_policy_map
  resource = turbot_policy_pack.azure_enabled_baseline_pack.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enabled"
}

# Here the "resource" is the AKA of the [Base Folder](../../guardrails/folder_hierarchy/) to which you want to attached the Policy Pack. 
# The base folder is created as part of script from [Base Folder](../../guardrails/folder_hierarchy/)
# The resource should be created first.
resource "turbot_policy_pack_attachment" "azure_enable_attachment" {
  resource    = "base_folder"
  policy_pack = turbot_policy_pack.azure_enabled_baseline_pack.id
}
