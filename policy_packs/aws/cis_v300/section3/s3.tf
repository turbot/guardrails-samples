# AWS > S3 > Bucket > Access Logging
resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  note     = "AWS CIS v3.0.0 - Controls: 3.4"
  value    = "Check: Enabled to Access Logging > Bucket"
  # value    = "Enforce: Enabled to Access Logging > Bucket"
}

# AWS > S3 > Bucket > Access Logging > Bucket
resource "turbot_policy_setting" "aws_s3_bucket_access_logging_bucket" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLoggingBucket"
  note           = "AWS CIS v3.0.0 - Controls: 3.4"
  template_input = var.logging_bucket != "" ? null : <<-EOT
    {
      turbotLoggingBucket: policy(uri: "aws#/policy/types/loggingBucketDefault")
    }
    EOT
  template       = var.logging_bucket != "" ? var.logging_bucket : <<-EOT
    {%- if $.turbotLoggingBucket -%}
      
      {{ $.turbotLoggingBucket | json }}
    
    {%- else -%}
    
      ""
    
    {%- endif -%}
  EOT
}
