# AWS > S3 > Bucket > Access Logging
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  note     = "AWS CIS v3.0.0 - Controls: 3.04"
  value    = "Check: Enabled to Access Logging > Bucket"
  # value = "Enforce: Enabled to Access Logging > Bucket"
}

# AWS > S3 > Bucket > Access Logging > Bucket
resource "turbot_policy_setting" "aws_s3_bucket_access_logging_bucket" {
  resource       = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLoggingBucket"
  note           = "AWS CIS v3.0.0 - Controls: 3.04"
  template_input = <<EOT
  {
    turbotLoggingBucket: policy(uri: "aws#/policy/types/loggingBucketDefault")
  }
EOT
  template       = <<EOT
{% if $.turbotLoggingBucket %}"{{ $.turbotLoggingBucket }}"{% else %}""{% endif %}
EOT
}
