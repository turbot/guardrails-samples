resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable Block Project-Wide SSH Keys for GCP Compute Engine Instances"
  description = "Restrict the use of universally accessible SSH keys, thereby reducing the risk of unauthorized access."
  akas        = ["gcp_computeengine_enforce_block_project_wide_ssh_keys_is_enabled_for_instances"]
}
