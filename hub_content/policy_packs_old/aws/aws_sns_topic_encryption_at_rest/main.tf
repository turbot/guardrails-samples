# Smart Folder Definition
resource "turbot_smart_folder" "sns_topic_encryption_at_rest" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > SNS > Topic> Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-sns/inspect#/policy/types/topicEncryptionAtRest
resource "turbot_policy_setting" "sns_topic_encryption_at_rest_enabled" {
  resource = turbot_smart_folder.sns_topic_encryption_at_rest.id
  type     = "tmod:@turbot/aws-sns#/policy/types/topicEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
  # "Skip"
  # "Check: None"
  # "Check: None or higher"
  # "Check: AWS managed key"
  # "Check: AWS managed key or higher"
  # "Check: Customer managed key"
  # "Check: Encryption at Rest > Customer Managed Key"
  # "Enforce: None"
  # "Enforce: AWS managed key"
  # "Enforce: AWS managed key or higher"
  # "Enforce: Customer managed key"
  # "Enforce: Encryption at Rest > Customer Managed Key"
}