resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Compute Disks Are Attached to Virtual Machines"
  description = "Ensure that all allocated storage is actively used and monitored, reducing the risk of unnecessary expenses and potential security vulnerabilities associated with unattached disks."
  akas        = ["azure_compute_enforce_disks_are_attached_to_vms"]
}
