# Azure > Storage > Storage Account > Access Tier
resource "turbot_policy_setting" "azure_storage_storage_account_access_tier" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessTier"
  value    = "Check: Cool"
  # value    = "Enforce: Cool"
}
