# Policy Pack
resource "turbot_smart_folder" "vpc_flow_logging" {
  title       = "AWS VPC flow logging with S3 bucket"
  description = "Create a policy pack to apply the Flow Log policy settings"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > VPC > Enabled
resource "turbot_policy_setting" "aws_cloudtrail_cloud_trail_enabled" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceEnabled"
  value    = "Enabled"
}
