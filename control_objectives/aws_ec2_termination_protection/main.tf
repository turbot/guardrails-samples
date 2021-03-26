# Smart Folder Definition
resource "turbot_smart_folder" "ec2_termination_protection" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > EC2 > Instance > Termination Protection
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceTerminationProtection
resource "turbot_policy_setting" "ec2_termination_protection_enabled" {
  resource = turbot_smart_folder.ec2_termination_protection.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceTerminationProtection"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Disabled"
  # "Enforce: Enabled"
}