resource "turbot_policy_pack" "main" {
  title       = "Enforce Block Public Access for Azure Storage Containers"
  description = "Ensure that sensitive data remains secure and compliant with regulatory standards, mitigating the risk of exposure to malicious actors."
  akas        = ["azure_storage_enforce_block_public_access_for_containers"]
}
