# CloudTrail Best Practices:
# Related to AWS CIS 2.02 Ensure CloudTrail log file validation is enabled (Scored)
resource "turbot_policy_setting" "aws_cloudtrail_trail_log_validation" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailLogFileValidation"
  value    = "Check: Enabled"
}

# Trail Status Check
resource "turbot_policy_setting" "aws_cloudtrail_trail_status" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailStatus"
  value    = "Check: No delivery errors"
}

# Trail Encryption
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRest"
  value    = "Check: Customer managed key"
          # "Skip"
          # "Check: None"
          # "Check: None or higher"
          # "Check: Customer managed key"
          # "Check: Encryption at Rest > Customer Managed Key"
          # "Enforce: None"
          # "Enforce: Customer managed key"
          # "Enforce: Encryption at Rest > Customer Managed Key"
}