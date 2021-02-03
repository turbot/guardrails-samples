# S3 Account level shouldn't be public or shared with unauthorized accounts
# Also set in the S3 Baseline as well.
# Note: this is for the Account level; another setting is for the Bucket level

# Set policy to check public access block settings
resource "turbot_policy_setting" "aws_s3_account_public_access_block" {
    resource   = turbot_smart_folder.aws_public_access.id
    type       = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
    value      = "Check: Per `Public Access Block  > Settings`"
}

## Set policy to apply public access block settings
resource "turbot_policy_setting" "aws_s3_account_public_access_block_settings" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
    value           = <<-VALUE
      - Block Public ACLs
      - Block Public Bucket Policies
      - Ignore Public ACLs
      - Restrict Public Bucket Policies
      VALUE
}