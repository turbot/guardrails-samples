# AWS > Turbot > Logging > Bucket
resource "turbot_policy_setting" "aws_turbot_logging_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Logging > Bucket > Access Logging
resource "turbot_policy_setting" "aws_turbot_logging_bucket_access_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketAccessLogging"
  value    = "Enabled"
}

# AWS > Turbot > Logging > Bucket > Default Encryption
resource "turbot_policy_setting" "aws_turbot_logging_bucket_encryption" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketDefaultEncryption"
  value    = "AWS SSE"
}

# AWS > Turbot > Logging > Bucket > Regions
resource "turbot_policy_setting" "aws_turbot_logging_bucket_regions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketRegions"
  value    = <<-EOT
    - us-east-1
    - us-east-2
  EOT
}

# AWS > Turbot > Logging > Bucket > Versioning
resource "turbot_policy_setting" "aws_turbot_logging_bucket_versioning" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketVersioning"
  value    = "Enabled"
}
