# AWS > S3 > Bucket > Encryption in Transit
resource "turbot_policy_setting" "aws_s3_encryption_in_transit" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
  note     = "AWS CIS v3.0.0 - Control: 2.1.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# AWS > S3 > Bucket > Public Access Block
resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  note     = "AWS CIS v3.0.0 - Control: 2.1.4"
  value    = "Check: Per `Public Access Block  > Settings`"
  # value    = "Enforce: Per `Public Access Block  > Settings`"
}

# AWS > S3 > Bucket > Public Access Block > Settings
resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block_settings" {
  resource = turbot_smart_folder.aws_cis_v_300_s_2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlockSettings"
  note     = "AWS CIS v3.0.0 - Control: 2.1.4"
  value    = <<-EOT
    - Block Public ACLs
    - Block Public Bucket Policies
    - Ignore Public ACLs
    - Restrict Public Bucket Policies
    EOT
}




