# AWS > S3 > Account > Public Access Block
resource "turbot_policy_setting" "aws_s3_account_public_access_block" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
  # value  = "Enforce: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Account > Public Access Block > Settings
resource "turbot_policy_setting" "aws_s3_account_public_access_block_settings" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
  value    = jsonencode(["Block Public ACLs"])
  # value  = jsonencode(["Block Public Bucket Policies"])
  # value  = jsonencode(["Ignore Public ACLs"])
  # value  = jsonencode(["Restrict Public Bucket Policies"])
}
