# Smart Folder Definition
resource "turbot_smart_folder" "dynamodb_point_in_time_recovery" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > DynamoDB > Table > Point-in-Time Recovery
# https://turbot.com/v5/mods/turbot/aws-dynamodb/inspect#/policy/types/tablePointInTimeRecovery
resource "turbot_policy_setting" "dynamodb_point_in_time_recovery_enabled" {
  resource = turbot_smart_folder.dynamodb_point_in_time_recovery.id
  type     = "tmod:@turbot/aws-dynamodb#/policy/types/tablePointInTimeRecovery"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Enabled"
  # "Check: Disabled"
  # "Enforce: Enabled"
  # "Enforce: Disabled"
}