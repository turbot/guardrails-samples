resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Disks to Be Attached to Instances"
  description = "Ensure that all allocated storage is actively used and monitored, reducing the risk of unnecessary expenses and potential security vulnerabilities associated with unattached disks."
  akas        = ["gcp_computeengine_enforce_disks_to_be_attached_to_instances"]
}
