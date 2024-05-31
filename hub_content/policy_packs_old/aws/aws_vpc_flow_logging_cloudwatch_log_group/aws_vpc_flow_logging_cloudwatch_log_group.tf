# AWS > VPC > VPC > Flow Logging
resource "turbot_policy_setting" "vpc_flow_logging" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  value    = "Check: Configured per `Flow Logging > *`"
  # value    = "Enforce: Configured per `Flow Logging > *`"
}

# AWS > VPC > VPC > Flow Logging > Log Format
resource "turbot_policy_setting" "vpc_flow_logging_log_format" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingLogFormat"
  # default log format
  value = ["version", "account-id", "interface-id", "srcaddr", "dstaddr", "srcport", "dstport", "protocol", "packets", "bytes", "start", "end", "action", "log-status"]
}

# AWS > VPC > VPC > Flow Logging > CloudWatch
resource "turbot_policy_setting" "vpc_flow_logging_cloudwatch" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatch"
  value    = "Enabled"
  # value    = "Disabled"
}

# AWS > VPC > VPC > Flow Logging > CloudWatch > Traffic Type
resource "turbot_policy_setting" "vpc_flow_logging_cloudwatch_traffic_type" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatchTrafficType"
  value    = "All"
}

# AWS > VPC > VPC > Flow Logging > CloudWatch > Log Group
# Uncomment the below if you want to use your own log group.
# Guardrails will use "/turbot/flowlogs/{{ $.vpc.VpcId }}" by default.

# resource "turbot_policy_setting" "vpc_flow_logging_cloudwatch_log_group" {
#   resource = turbot_smart_folder.vpc_flow_logging.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatchLogGroup"
#   value    = "<cloudwatch-log-group-name>"  # Replace with your log group name
# }

# AWS > VPC > VPC > Flow Logging > CloudWatch > Role
# Uncomment the below if  you want to use your own CloudWatch role.
# By defautl, Guardrails will use the flow logging role created via `AWS > Turbot > Service Roles` stack.
# resource "turbot_policy_setting" "vpc_flow_logging_cloudwatch_role" {
#   resource = turbot_smart_folder.vpc_flow_logging.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatchRole"
#   value    = "<cloudwatch-role-name>"  # Replace with your CloudWatch role name
# }