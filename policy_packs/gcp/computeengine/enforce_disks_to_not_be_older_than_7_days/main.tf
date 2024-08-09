resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Disks Are Not Older Than 7 Days"
  description = "Enforcing disks to not be older than 7 days is critical to ensure that data storage is continuously refreshed and aligned with the latest security and performance standards."
  akas        = ["gcp_computeengine_enforce_disks_to_not_be_older_than_7_days"]
}
