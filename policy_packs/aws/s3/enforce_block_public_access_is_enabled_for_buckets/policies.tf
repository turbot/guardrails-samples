# AWS > S3 > Bucket > Public Access Block
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
  # value    = "Enforce: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Bucket > Public Access Block > Settings
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block_settings" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  value    = <<-EOT
    - "Block Public ACLs"
    - "Block Public Bucket Policies"
    - "Ignore Public ACLs"
    - "Restrict Public Bucket Policies"
    EOT
}
