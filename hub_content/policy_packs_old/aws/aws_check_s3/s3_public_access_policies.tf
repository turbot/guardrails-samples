# Public Access Guardrails
#   https://turbot.com/v5/docs/concepts/guardrails/public-access

### S3 Account Level Public Access Block Policies ###

# AWS > S3 > Account > Public Access Block
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3AccountPublicAccessBlock
resource "turbot_policy_setting" "aws_s3_s3_account_public_access_block" {
  count    = var.enable_s3_public_access_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Account > Public Access Block > Settings
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3AccountPublicAccessBlockSettings
resource "turbot_policy_setting" "aws_s3_s3_account_public_access_block_settings" {
  count    = var.enable_s3_public_access_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
  value    = <<EOT
    - Block Public ACLs
    - Block Public Bucket Policies
    - Ignore Public ACLs
    - Restrict Public Bucket Policies
  EOT
}

### S3 Bucket Level Public Access Block Policies ###

# AWS > S3 > Bucket > Public Access Block
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3BucketPublicAccessBlock
resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block" {
  count    = var.enable_s3_public_access_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Bucket > Public Access Block > Settings
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3BucketPublicAccessBlockSettings
resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block_settings" {
  count    = var.enable_s3_public_access_policies ? 1 : 0
  resource = turbot_smart_folder.aws_all_s3.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  value    = <<EOT
    - Block Public ACLs
    - Block Public Bucket Policies
    - Ignore Public ACLs
    - Restrict Public Bucket Policies
  EOT
}
