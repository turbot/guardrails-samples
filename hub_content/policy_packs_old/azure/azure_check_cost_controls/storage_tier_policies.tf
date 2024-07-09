# Check for Storage access tier to be cool for a cost savings

resource "turbot_policy_setting" "azure_storage_access_tier" {
  resource = turbot_smart_folder.azure_cost_controls.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessTier"
  value    = "Check: Cool"
}
