resource "turbot_smart_folder" "vpc_flow_logging" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the Flow Log policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting VPC Flow logging for the VPC.
# AWS > VPC > VPC > Flow Logging
# Alternate values include:

/*
- Skip
- Check: Configured per `Flow Logging > *`
- Check: Not configured
- Enforce: Configured per `Flow Logging > *`
- Enforce: Not configured
*/

resource "turbot_policy_setting" "vpc_flow_logs" {
    resource = turbot_smart_folder.vpc_flow_logging.id
    type = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
    value = "Check: Not configured"
}