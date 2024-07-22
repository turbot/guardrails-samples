# AWS > VPC > VPC > Flow Logging
resource "turbot_policy_setting" "vpc_flow_logs" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  value    = "Check: Not configured"
  # value = "Enforce: Not configured"
}