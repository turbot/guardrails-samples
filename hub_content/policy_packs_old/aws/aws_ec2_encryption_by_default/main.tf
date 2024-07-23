# Smart Folder Definition
resource "turbot_smart_folder" "aws_ec2_encryption_by_default" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# AWS > EC2 > Account Attributes > EBS Encryption by Default
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/ec2AccountAttributesEbsEncryptionByDefault
resource "turbot_policy_setting" "aws_ec2_encryption_by_default_enabled" {
  resource = turbot_smart_folder.aws_ec2_encryption_by_default.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesEbsEncryptionByDefault"
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