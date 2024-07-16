resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption in Transit for Azure Storage Accounts"
  description = "Ensure that only authenticated and authorized users can interact with the stored data, thus enhancing security and compliance with data protection regulations."
  akas        = ["azure_storage_enforce_encryption_in_transit_for_storage_accounts"]
}
