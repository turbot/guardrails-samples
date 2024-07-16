resource "turbot_policy_pack" "main" {
  title       = "Delete Unattached Disks Active for more than 7 Days"
  description = "Unattached disks that have been active for more than 7 days should be deleted."
  akas        = ["gcp_computeengine_enforce_unattached_disks_active_more_than_7_days"]
}
