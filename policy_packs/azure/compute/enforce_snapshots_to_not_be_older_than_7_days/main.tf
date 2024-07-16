resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Snapshots to Not Be Older Than 7 Days"
  description = "Ensure that snapshots are recent, which reduces the risk of data loss and ensuring quick recovery in case of issues, while also adhering to best practices."
  akas        = ["azure_compute_enforce_snapshots_to_not_be_older_than_7_days"]
}
