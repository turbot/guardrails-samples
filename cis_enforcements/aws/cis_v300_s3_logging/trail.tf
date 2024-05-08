# AWS > Turbot > Audit Trail
resource "turbot_policy_setting" "aws_audit_trail" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  note     = "AWS CIS v3.0.0 - Controls: 3.01"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Global Region
resource "turbot_policy_setting" "aws_trail_global_region" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/trailGlobalRegion"
  note     = "AWS CIS v3.0.0 - Controls: 3.01"
  value    = "us-east-1"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Type
resource "turbot_policy_setting" "aws_trail_type" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/trailType"
  note     = "AWS CIS v3.0.0 - Controls: 3.01"
  value    = "A multi-region trail in the `Trail > Global Region` in each account"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Encryption Key 
resource "turbot_policy_setting" "aws_trail_encryption_key" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/trailEncryptionKey"
  note     = "AWS CIS v3.0.0 - Controls: 3.01"
  value    = var.encryption_key
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > S3 Bucket
resource "turbot_policy_setting" "aws_trail_bucket" {
  resource       = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type           = "tmod:@turbot/aws#/policy/types/trailBucket"
  note           = "AWS CIS v3.0.0 - Controls: 3.01"
  template_input = var.logging_bucket != "" ? null : <<-EOT
{
  turbotLoggingBucket: policy(uri: "aws#/policy/types/loggingBucketDefault")
}
EOT
  template       = var.logging_bucket != "" ? var.logging_bucket : <<-EOT
{% if $.turbotLoggingBucket %}"{{ $.turbotLoggingBucket }}"{% else %}""{% endif %}
EOT
}

# AWS > Turbot > Logging > Bucket
resource "turbot_policy_setting" "aws_logging_bucket" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  note     = "AWS CIS v3.0.0 - Controls: 3.01"
  value    = "Check: Configured"
  # value = "Enforce: Configured"
}

# AWS > Turbot > Logging > Bucket > Encryption in Transit
resource "turbot_policy_setting" "aws_logging_bucket_encryption_in_transit" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketEncryptionInTransit"
  note     = "AWS CIS v3.0.0 - Controls: 3.01"
  value    = "Enabled"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Event Selectors
resource "turbot_policy_setting" "aws_trail_event_selectors" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws#/policy/types/trailEventSelectors"
  note     = "AWS CIS v3.0.0 - Controls: 3.01 & 3.08 & 3.09"
  value    = <<-EOT
event_selector {
  read_write_type           = "All"
  include_management_events = true
  data_resource {
    type   = "AWS::S3::Object"
    values = ["arn:aws:s3"]
  }
}
EOT
}

# AWS > CloudTrail > Trail > Log File Validation
resource "turbot_policy_setting" "aws_cloudtrail_trail_log_file_validation" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailLogFileValidation"
  note     = "AWS CIS v3.0.0 - Controls: 3.02"
  value    = "Check: Enabled"
  # value = "Enforce: Enabled"

}

# AWS > CloudTrail > Trail > Encryption at Rest
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Controls: 3.05"
  value    = "Check: Encryption at Rest > Customer Managed Key"
  # value = "Enforce: Encryption at Rest > Customer Managed Key"
}

# AWS > CloudTrail > Trail > Encryption at Rest > Customer Managed Key
# The KMS key must have a key policy set to grant encrypt permission.
# Reference: https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-kms-key-policy-for-cloudtrail.html
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRestCustomerManagedKey"
  note     = "AWS CIS v3.0.0 - Controls: 3.05"
  value    = var.encryption_key
}
