# AWS > Turbot > Audit Trail
resource "turbot_policy_setting" "aws_audit_trail" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Global Region
resource "turbot_policy_setting" "aws_trail_global_region" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailGlobalRegion"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  value    = "us-east-1"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Type
resource "turbot_policy_setting" "aws_trail_type" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailType"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  value    = "A multi-region trail in the `Trail > Global Region` in each account"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Encryption Key 
resource "turbot_policy_setting" "aws_trail_encryption_key" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws#/policy/types/trailEncryptionKey"
  note           = "AWS CIS v3.0.0 - Controls: 3.1"
  template_input = <<-EOT
    {
      resource {
        children(filter: "resourceTypeId:tmod:@turbot/aws-kms#/resource/types/key level:self,descendant limit:5000") {
          items {
            AliasName: get(path: "AliasName")
            KeyArn: get(path: "KeyArn")
          }
        }
      }
    }
    EOT
  template       = <<-EOT
    {%-  for key in $.resource.children.items -%}
      
      {%- if key.AliasName == "${var.kms_key_alias}" -%}
      
        {{ key.KeyArn | json }}
      
      {%- endif -%}
    
    {%- endfor -%}
    EOT
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > S3 Bucket
resource "turbot_policy_setting" "aws_trail_bucket" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws#/policy/types/trailBucket"
  note           = "AWS CIS v3.0.0 - Controls: 3.1"
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

# AWS > Turbot > Logging > Bucket
resource "turbot_policy_setting" "aws_logging_bucket" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Logging > Bucket > Encryption in Transit
resource "turbot_policy_setting" "aws_logging_bucket_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketEncryptionInTransit"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  value    = "Enabled"
}

# AWS > Turbot > Audit Trail > CloudTrail > Trail > Event Selectors
resource "turbot_policy_setting" "aws_trail_event_selectors" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws#/policy/types/trailEventSelectors"
  note     = "AWS CIS v3.0.0 - Controls: 3.1 & 3.8 & 3.9"
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
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailLogFileValidation"
  note     = "AWS CIS v3.0.0 - Controls: 3.2"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# AWS > CloudTrail > Trail > Encryption at Rest
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Controls: 3.5"
  value    = "Check: Encryption at Rest > Customer Managed Key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}

# AWS > CloudTrail > Trail > Encryption at Rest > Customer Managed Key
# Ensure the CMK is located in the same region as the S3 bucket
# You will need to apply a KMS Key policy on the selected CMK in order for CloudTrail as a service
# to encrypt and decrypt log files using the CMK provided.
# Reference: https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-kms-key-policy-for-cloudtrail.html
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRestCustomerManagedKey"
  note     = "AWS CIS v3.0.0 - Controls: 3.5"
  value    = var.kms_key_alias
}
