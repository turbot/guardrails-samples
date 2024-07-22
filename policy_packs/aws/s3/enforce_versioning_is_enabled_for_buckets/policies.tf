# AWS > S3 > Bucket > Versioning
resource "turbot_policy_setting" "aws_s3_bucket_versioning" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketVersioning"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
