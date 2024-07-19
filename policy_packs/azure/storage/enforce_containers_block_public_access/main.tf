resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Storage Containers Block Public Access"
  description = "Ensure that storage containers are not publicly accessible, organizations can safeguard sensitive data."
  akas        = ["azure_storage_enforce_containers_block_public_access"]
}
