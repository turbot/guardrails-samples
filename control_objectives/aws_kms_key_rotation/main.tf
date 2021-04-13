# Smart Folder Definition
resource "turbot_smart_folder" "aws_kms_key_rotation" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > KMS > Key > Rotation
# https://turbot.com/v5/mods/turbot/aws-kms/inspect#/policy/types/keyRotation
resource "turbot_policy_setting" "aws_kms_key_rotation_enabled" {
  resource = turbot_smart_folder.aws_kms_key_rotation.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Enabled"
  # "Enforce: Disabled"
}