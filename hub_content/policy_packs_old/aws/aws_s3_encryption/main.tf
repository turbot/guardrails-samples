# S3 encryption policies

resource "turbot_smart_folder" "s3_encryption" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to set the RDS approved policy"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting Encryption at rest on S3

# Setting value to "Check: AWS SSE or higher" to check AWS Server Side Encryption or Higher for buckets
# AWS > S3 > Bucket > Encryption at Rest

resource "turbot_policy_setting" "s3_bucket_defaultEncryption" {
  resource = turbot_smart_folder.s3_encryption.id
  type = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  value = "Check: AWS SSE or higher"
}

# Enforce Object Storage Encryption in Transit

# Setting value to "Check: Enabled" for Encryption in Transit on S3 Buckets
# AWS > S3 > Bucket > Encryption in Transit

resource "turbot_policy_setting" "s3_bucket_encryption_transit" {
    resource = turbot_smart_folder.s3_encryption.id
    type = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
    value = "Check: Enabled"
}