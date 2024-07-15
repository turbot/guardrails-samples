resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable Block Project-Wide SSH Keys for GCP Compute Engine Instances"
  description = "Restrict the use of universally accessible SSH keys, thereby reducing the risk of unauthorized access."
  parent      = "tmod:@turbot/turbot#/"
}
