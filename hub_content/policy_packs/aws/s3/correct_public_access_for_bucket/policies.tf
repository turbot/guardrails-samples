# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
  # value  = "Enforce: Stop unapproved"
}

# AWS > S3 > Bucket > Public Access Block
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  value    = "Check: Per `Public Access Block  > Settings`"
  # value  = "Enforce: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Bucket > Public Access Block > Settings
resource "turbot_policy_setting" "aws_s3_bucket_public_access_block_settings" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  value    = jsonencode(["Block Public ACLs"])
  # value  = jsonencode(["Block Public Bucket Policies"])
  # value  = jsonencode(["Ignore Public ACLs"])
  # value  = jsonencode(["Restrict Public Bucket Policies"])
}
