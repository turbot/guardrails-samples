# AWS CloudTrail Global Trail can be setup by Turbot
# more info: https://turbot.com/v5/docs/integrations/aws/event-handlers#configuring-cloudtrail

# You are not required to use the Turbot Audit Trail to configure CloudTrail in order to configure Turbot real time events
# But there must be a CloudTrail configured in each region.
# AWS > Turbot > Audit Trail

# resource "turbot_policy_setting" "auditTrail" {
#  resource    = turbot_smart_folder.aws_logging.id
#  type        = "tmod:@turbot/aws#/policy/types/auditTrail"
#  value       = "Check: Configured"
# Skip
# Check: Configured
# Check: Not configured
# Enforce: Configured
# Enforce: Not configured
# }

# CloudTrail Best Practices

# Related to AWS CIS 2.02 Ensure CloudTrail log file validation is enabled (Scored)
# https://turbot.com/v5/mods/turbot/aws-cloudtrail/inspect#/policy/types/trailLogFileValidation
resource "turbot_policy_setting" "aws_cloudtrail_trail_log_validation" {
  count    = var.enable_cloudtrail_trail_log_validation ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailLogFileValidation"
  value    = "Check: Enabled"
}

# Trail Status Check
# https://turbot.com/v5/mods/turbot/aws-cloudtrail/inspect#/policy/types/trailStatus
resource "turbot_policy_setting" "aws_cloudtrail_trail_status" {
  count    = var.enable_cloudtrail_trail_status ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailStatus"
  value    = "Check: No delivery errors"
}

# Trail Encryption
# https://turbot.com/v5/mods/turbot/aws-cloudtrail/inspect#/policy/types/trailEncryptionAtRest
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  count    = var.enable_cloudtrail_trail_encryption ? 1 : 0
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