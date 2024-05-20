# Smart Folder Definition
resource "turbot_smart_folder" "block_project_wide_ssh_keys" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# GCP > Compute Engine > Instance > Block Project Wide SSH Keys
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/instanceBlockProjectWideSshKeys
resource "turbot_policy_setting" "instance_block_project_wide_ssh_keys" {
  resource = turbot_smart_folder.block_project_wide_ssh_keys.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Disabled"
  # "Enforce: Enabled"
}