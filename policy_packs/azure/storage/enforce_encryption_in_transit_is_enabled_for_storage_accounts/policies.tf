# Azure > Storage > Storage Account > Encryption in Transit
resource "turbot_policy_setting" "azure_storage_storage_account_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountEncryptionInTransit"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
