resource "turbot_policy_setting" "vpc_flow_logs" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  value    = "Check: Configured per `Flow Logging > *`"
  # value = "Enforce: Configured per `Flow Logging > *`"
}
