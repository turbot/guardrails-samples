resource "turbot_policy_pack" "main" {
  title       = "Enforce Minimum TLS Version for Azure Storage Accounts"
  description = "Ensure that all data transmissions to and from the storage accounts use a specified version of TLS."
  akas        = ["azure_storage_enforce_minimum_tls_version_for_storage_accounts"]
}
