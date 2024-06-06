# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
  # value  = "Enforce: Stop unapproved"
}

# AWS > S3 > Bucket > Encryption at Rest
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
  # value  = "Check: AWS SSE"
  # value  = "Check: AWS SSE or higher"
  # value  = "Check: AWS managed key"
  # value  = "Check: AWS managed key or higher"
  # value  = "Check: Customer managed key"
  # value  = "Check: Encryption at Rest > Customer Managed Key"
  # value  = "Enforce: AWS SSE"
  # value  = "Enforce: AWS SSE or higher"
  # value  = "Enforce: AWS managed key"
  # value  = "Enforce: AWS managed key or higher"
  # value  = "Enforce: Customer managed key"
  # value  = "Enforce: Encryption at Rest > Customer Managed Key"
}

# AWS > S3 > Bucket > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRestCustomerManagedKey"
  # Update with default encryption key/alias below
  value = "alias/turbot/default"
}
