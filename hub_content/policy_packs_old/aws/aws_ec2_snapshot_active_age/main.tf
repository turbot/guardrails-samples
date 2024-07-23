# Smart Folder Definition
resource "turbot_smart_folder" "ec2_snapshot_retention" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > EC2 > Snapshot > Active
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotActive
resource "turbot_policy_setting" "ec2_snapshot_active" {
  resource = turbot_smart_folder.ec2_snapshot_retention.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActive"
  value    = "Check: Active"
  # "Skip",
  # "Check: Active"
  # "Enforce: Delete inactive with 1 day warning"
  # "Enforce: Delete inactive with 3 days warning"
  # "Enforce: Delete inactive with 7 days warning"
  # "Enforce: Delete inactive with 14 days warning"
  # "Enforce: Delete inactive with 30 days warning"
  # "Enforce: Delete inactive with 60 days warning"
  # "Enforce: Delete inactive with 90 days warning"
  # "Enforce: Delete inactive with 180 days warning"
  # "Enforce: Delete inactive with 365 days warning"
}

# AWS > EC2 > Snapshot > Active > Age
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotActive
resource "turbot_policy_setting" "ec2_snapshot_active_age" {
  resource = turbot_smart_folder.ec2_snapshot_retention.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActiveAge"
  value    = "Force inactive if age > 7 days"
  # "Skip",
  # "Force inactive if age > 1 day"
  # "Force inactive if age > 3 days"
  # "Force inactive if age > 7 days"
  # "Force inactive if age > 14 days"
  # "Force inactive if age > 30 days"
  # "Force inactive if age > 60 days"
  # "Force inactive if age > 90 days"
  # "Force inactive if age > 180 days"
  # "Force inactive if age > 365 days"
}