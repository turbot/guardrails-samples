# Smart Folder Definition
resource "turbot_smart_folder" "ecr_repo_scan_on_push" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > ECR > Repository > Scan on Push
# https://turbot.com/v5/mods/turbot/aws-ecr/inspect#/policy/types/repositoryScanOnPush
resource "turbot_policy_setting" "ecr_repo_scan_on_push_enabled" {
  resource = turbot_smart_folder.ecr_repo_scan_on_push.id
  type     = "tmod:@turbot/aws-ecr#/policy/types/repositoryScanOnPush"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Enabled"
  # "Check: Disabled"
  # "Enforce: Enabled"
  # "Enforce: Disabled"
}