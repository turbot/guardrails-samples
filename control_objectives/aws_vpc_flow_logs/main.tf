resource "turbot_smart_folder" "baseline" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the s3 policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

### Decision on CW log group or S3 and Traffic(Accept&Rejects or just one?)

### Setting VPC Flow logging for the VPC.
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
    resource = turbot_smart_folder.va_logging.id
    type = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
    value = "Check: Not configured"
}