# AWS VPC Flow Logs Setup by Turbot
# Commented out since it will always error without Turbot Enforcing its own configs
# 2.09 Ensure VPC flow logging is enabled in all VPCs (Scored)

# AWS > VPC > VPC > Flow Logging
# https://turbot.com/v5/mods/turbot/aws-vpc-core/inspect#/policy/types/vpcFlowLogging
resource "turbot_policy_setting" "vpcFlowLogging" {
  count    = var.enable_aws_vpc_flowlogging ? 1 : 0
  resource = turbot_smart_folder.aws_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  value    = "Check: Configured per `Flow Logging > *`"
            #   Skip
            #   Check: Configured per `Flow Logging > *`
            #   Check: Not configured
            #   Enforce: Configured per `Flow Logging > *`
            #   Enforce: Not configured`
            }
