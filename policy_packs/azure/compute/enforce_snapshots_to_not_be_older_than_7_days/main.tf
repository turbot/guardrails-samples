resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Snapshots to Not Be Older Than 7 Days"
  description = "Replacement of snapshots within a 7-day period"
  akas        = ["azure_compute_enforce_snapshots_to_not_be_older_than_7_days"]
}
