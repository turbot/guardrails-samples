# AWS > S3 > Account > Public Access Block
resource "turbot_policy_setting" "aws_s3_account_public_access_block" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
  # value    = "Enforce: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Account > Public Access Block > Settings
resource "turbot_policy_setting" "aws_s3_account_public_access_block_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3AccountPublicAccessBlockSettings"
  value    = <<-EOT
    - "Block Public ACLs"
    - "Block Public Bucket Policies"
    - "Ignore Public ACLs"
    - "Restrict Public Bucket Policies"
    EOT
}
