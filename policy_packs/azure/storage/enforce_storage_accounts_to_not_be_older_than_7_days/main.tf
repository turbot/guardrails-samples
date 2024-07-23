resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Storage Accounts to Not Be Older Than 7 Days"
  description = "Ensure that storage accounts are recent, which reduces the risk of data loss and ensuring quick recovery in case of issues, while also adhering to best practices."
  akas        = ["azure_storage_enforce_storage_accounts_to_not_be_older_than_7_days"]
}
