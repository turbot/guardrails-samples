# AWS > VPC > VPC > Flow Logging
resource "turbot_policy_setting" "aws_vpc_core_vpc_flow_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  note     = "AWS CIS v3.0.0 - Controls: 3.7"
  value    = "Check: Configured per `Flow Logging > *`"
  # value    = "Enforce: Configured per `Flow Logging > *`"
}
