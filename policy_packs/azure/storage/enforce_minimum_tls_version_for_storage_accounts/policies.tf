# Azure > Storage > Storage Account > Minimum TLS Version
resource "turbot_policy_setting" "azure_storage_storage_account_minimum_tls_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountMinimumTlsVersion"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
