resource "turbot_policy_pack" "main" {
  title       = "Enforce Minimum TLS Version for Azure Storage Accounts"
  description = "Ensure that overall security by requiring the use of stronger, more modern encryption protocols, mitigating the risks associated with outdated or vulnerable versions of TLS."
  akas        = ["azure_storage_enforce_minimum_tls_version_for_storage_accounts"]
}
