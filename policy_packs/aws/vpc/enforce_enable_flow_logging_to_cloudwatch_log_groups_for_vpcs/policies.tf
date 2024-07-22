# AWS > VPC > VPC > Flow Logging
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  value    = "Check: Configured per `Flow Logging > *`"
  # value    = "Enforce: Configured per `Flow Logging > *`"
}

# AWS > VPC > VPC > Flow Logging > Cloud Watch
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging_cloudwatch" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatch"
  value    = "Enabled"
}

# AWS > VPC > VPC > Flow Logging > S3 > Cloud Watch > Log Group
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging_cloudwatch_log_group" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatchLogGroup"
  # Your CloudWatch log group name. Defaults to `/turbot/flowlogs/<VPC Id>`
  value    = "myloggroup"
}

# AWS > VPC > VPC > Flow Logging > CloudWatch > Role
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging_cloudwatch_role" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingCloudWatchRole"
  # Your IAM role that flow logging will assume to write logs to CloudWatch log group. Defaults to role created via `AWS > Turbot > Service Roles` control
  value    = "myrole"
}
