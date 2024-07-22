# GCP > Compute Engine > Disk > Active
resource "turbot_policy_setting" "gcp_compute_engine_disk_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# GCP > Compute Engine > Disk > Active > Attached
resource "turbot_policy_setting" "gcp_compute_engine_disk_active_attached" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskActiveAttached"
  value    = "Force inactive if unattached"
}
