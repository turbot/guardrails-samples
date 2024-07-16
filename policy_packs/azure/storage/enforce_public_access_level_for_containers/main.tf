resource "turbot_policy_pack" "main" {
  title       = "Enforce Public Access Level for Azure Storage Containers"
  description = "Ensure that sensitive data remains secure and compliant with regulatory standards, mitigating the risk of exposure to malicious actors."
  akas        = ["azure_storage_enforce_public_access_level_for_containers"]
}
