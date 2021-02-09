# S3 Bucket level shouldn't be public or shared with unauthorized accounts
# Also set in the S3 Baseline as well.
# Note: this is for the Bucket level; another setting is for the Account level

# Set policy to check public access block settings
# AWS > S3 > Bucket > Public Access Block
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3BucketPublicAccessBlock
resource "turbot_policy_setting" "aws_s3_public_access_block" {
  count    = var.enable_aws_s3_public_access_block ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
}

## Set policy to apply public access block settings
# AWS > S3 > Bucket > Public Access Block > Settings
# https://turbot.com/v5/mods/turbot/aws-s3/inspect#/policy/types/s3BucketPublicAccessBlockSettings
resource "turbot_policy_setting" "aws_s3_public_access_block_settings" {
  count    = var.enable_aws_s3_public_access_block_settings ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  value    = <<-VALUE
      - Block Public ACLs
      - Block Public Bucket Policies
      - Ignore Public ACLs
      - Restrict Public Bucket Policies
      VALUE
}
