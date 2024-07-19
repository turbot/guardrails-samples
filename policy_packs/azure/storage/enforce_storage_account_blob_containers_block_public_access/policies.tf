# Azure > Storage > Storage Account > Public Access
resource "turbot_policy_setting" "azure_storage_storage_account_blob_public_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountPublicAccess"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
