# Azure > Storage > Storage Account > Active
resource "turbot_policy_setting" "azure_storage_storage_account_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# Azure > Storage > Storage Account > Active > Age
resource "turbot_policy_setting" "azure_storage_storage_account_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountActiveAge"
  value    = "Force inactive if age > 7 days"
}
