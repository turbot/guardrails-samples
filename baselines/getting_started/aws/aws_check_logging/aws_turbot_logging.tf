# Turbot AWS Logging Configurations to automatically setup Flow Logs, Config Recording, Global Trail
# Optional if you are using Turbot to enforce the configuration

# AWS Config Recording setup by Turbot
# Commented out since it will always error without Turbot Enforcing its own configs
# 2.05 Ensure AWS Config is enabled in all regions (Scored)

# resource "turbot_policy_setting" "configurationRecording" {
#  resource = turbot_smart_folder.aws_logging.id
#  type     = "tmod:@turbot/aws-config#/policy/types/configurationRecording"
#  value    = "Check: Configured"
              # Skip
              # Check: Configured
              # Check: Not Configured
              # Enforce: Configured
              # Enforce: Not Configured
# }


# AWS VPC Flow Logs Setup by Turbot
# Commented out since it will always error without Turbot Enforcing its own configs
# 2.09 Ensure VPC flow logging is enabled in all VPCs (Scored)

# resource "turbot_policy_setting" "vpcFlowLogging" {
#  resource = turbot_smart_folder.aws_logging.id
#  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
#  value    = "Check: Configured per `Flow Logging > *`"
              # Skip
              # Check: Configured per `Flow Logging > *`
              # Check: Not configured
              # Enforce: Configured per `Flow Logging > *`
              # Enforce: Not configured`
# }

# AWS CloudTrail Global Trail can be setup by Turbot, more info: https://turbot.com/v5/docs/integrations/aws/event-handlers#configuring-cloudtrail
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