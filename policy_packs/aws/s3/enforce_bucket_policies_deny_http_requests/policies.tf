# AWS > S3 > Bucket > Encryption in Transit
resource "turbot_policy_setting" "aws_s3_bucket_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
