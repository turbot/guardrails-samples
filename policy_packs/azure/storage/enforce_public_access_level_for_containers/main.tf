resource "turbot_policy_pack" "main" {
  title       = "Enforce Public Access Level for Azure Storage Containers"
  description = "Ensure that only authenticated and authorized users can interact with the stored data, thus enhancing security and compliance with data protection regulations."
  akas        = ["azure_storage_enforce_public_access_level_for_containers"]
}
