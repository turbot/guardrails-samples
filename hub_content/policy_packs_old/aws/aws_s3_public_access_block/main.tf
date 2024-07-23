# Smart Folder Definition
resource "turbot_smart_folder" "s3_public_access_block" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 

# AWS > S3 > Account > Public Access Block > Settings
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3AccountPublicAccessBlockSettings
resource "turbot_policy_setting" "aws_s3_account_public_access_block_settings" {
  resource = turbot_smart_folder.s3_public_access_block.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
  value    = <<EOT
  - Block Public ACLs
  - Block Public Bucket Policies
  - Ignore Public ACLs
  - Restrict Public Bucket Policies
EOT
}

# AWS > S3 > Account > Public Access Block
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3AccountPublicAccessBlock
resource "turbot_policy_setting" "aws_s3_account_public_access_block" {
  resource = turbot_smart_folder.s3_public_access_block.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
  # Skip
  # Check: Per `Public Access Block  > Settings`
  # Enforce: Per `Public Access Block  > Settings`
}


# AWS > S3 > Bucket > Public Access Block > Settings
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3BucketPublicAccessBlockSettings
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block_settings" {
  resource = turbot_smart_folder.s3_public_access_block.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  value    = <<EOT
  - Block Public ACLs
  - Block Public Bucket Policies
  - Ignore Public ACLs
  - Restrict Public Bucket Policies
EOT
}

# AWS > S3 > Bucket > Public Access Block
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3BucketPublicAccessBlock
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block" {
  resource = turbot_smart_folder.s3_public_access_block.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
  # Skip
  # Check: Per `Public Access Block  > Settings`
  # Enforce: Per `Public Access Block  > Settings`
}