# AWS > VPC > VPC > Flow Logging
resource "turbot_policy_setting" "aws_vpc_core_vpc_flow_logging" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  note     = "AWS CIS v3.0.0 - Controls: 3.7"
  value    = "Check: Configured per `Flow Logging > *`"
  # value    = "Enforce: Configured per `Flow Logging > *`"
}
