# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
  # value  = "Enforce: Stop unapproved"
  # value  = "Enforce: Stop unapproved if new"
  # value  = "Enforce: Delete unapproved if new"
}

# AWS > S3 > Bucket > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_s3_bucket_approved_bucketEncryptionAtRest" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  value    = "AWS managed key or higher"
  # value  = "None"
  # value  = "None or higher"
  # value  = "AWS SSE"
  # value  = "AWS SSE or higher"
  # value  = "AWS managed key"
  # value  = "AWS managed key or higher"
  # value  = "Customer managed key"
  # value  = "Encryption at Rest > Customer Managed Key"
}

# AWS > S3 > Bucket > Approved > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_s3_bucket_approved_bucketEncryptionAtRestCustomerManagedKey" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRestCustomerManagedKey"
  # Update with default encryption key/alias below
  value = "alias/turbot/default"
}
