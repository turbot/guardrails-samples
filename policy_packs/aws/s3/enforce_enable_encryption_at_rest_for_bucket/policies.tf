# AWS > S3 > Bucket > Encryption at Rest
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
  # value    = "Enforce: AWS managed key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}

# AWS > S3 > Bucket > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRestCustomerManagedKey"
  # Add your CMK id/arn/alias below
  value    = "alias/turbot/default"
}
