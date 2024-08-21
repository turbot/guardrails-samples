resource "turbot_policy_pack" "main" {
  title       = "Enforce Secure TLS Version for Azure Storage Accounts"
  description = "Ensure data is protected by using strong encryption protocols, reducing the risk of vulnerabilities associated with older TLS versions"
  akas        = ["azure_storage_enforce_secure_tls_version_for_storage_accounts"]
}
