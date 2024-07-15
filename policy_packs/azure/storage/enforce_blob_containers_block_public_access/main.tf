resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Storage Blob Containers Block Public Access"
  description = "Ensure that only authenticated and authorized users can interact with the stored data, thus enhancing security and compliance with data protection regulations."
  akas        = ["azure_storage_enforce_blob_containers_block_public_access"]
}
