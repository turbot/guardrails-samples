resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Storage Accounts to Not Be Older Than 7 Days"
  description = "Replacement of storage accounts within a 7-day period"
  akas        = ["azure_storage_enforce_storage_accounts_to_not_be_older_than_7_days"]
}
