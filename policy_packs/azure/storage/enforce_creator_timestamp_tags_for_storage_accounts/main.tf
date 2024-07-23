resource "turbot_policy_pack" "main" {
  title       = "Enforce Creator and Create Timestamp Tags for Azure Storage Account"
  description = "Ensure that each storage account is tagged with information about who created it and when it was created."
  akas        = ["azure_storage_enforce_creator_timestamp_tags_for_storage_accounts"]
}
