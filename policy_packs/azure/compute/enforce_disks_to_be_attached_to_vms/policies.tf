# Azure > Compute > Disk > Active
resource "turbot_policy_setting" "azure_compute_disk_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# Azure > Compute > Disk > Active > Attached
resource "turbot_policy_setting" "azure_compute_disk_active_attached" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskActiveAttached"
  value    = "Force inactive if unattached"
}
