resource "turbot_policy_pack" "main" {
  title       = "Azure Compute Enforce Disks Block Public Network Access"
  description = "Enforce that Azure Disk public network access is disabled."
  akas        = ["azure_compute_enforce_disks_block_public_network_access"]
}
