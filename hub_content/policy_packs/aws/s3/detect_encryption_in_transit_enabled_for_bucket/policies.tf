# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
  # value  = "Enforce: Stop unapproved"
  # value  = "Enforce: Stop unapproved if new"
  # value  = "Enforce: Delete unapproved if new"
}

# AWS > S3 > Bucket > Approved > Encryption in Transit
resource "turbot_policy_setting" "aws_s3_bucket_approved_bucketEncryptionInTransit" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
  value    = "Enabled"
  # value  = "Disabled"
  # value  = "Enabled"
}
