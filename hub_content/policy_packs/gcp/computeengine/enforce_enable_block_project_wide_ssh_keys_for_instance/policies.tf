# GCP > Compute Engine > Instance > Block Project Wide SSH Keys
resource "turbot_policy_setting" "gcp_compute_engine_instance_block_project_wide_ssh_keys" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
