# Azure > Compute > Snapshot > Active
resource "turbot_policy_setting" "azure_compute_snapshot_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/snapshotActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# Azure > Compute > Snapshot > Active > Age
resource "turbot_policy_setting" "azure_compute_snapshot_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/snapshotActiveAge"
  value    = "Force inactive if age > 7 days"
}
