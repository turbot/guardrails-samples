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
  # Default log format
  value = ["version", "account-id", "interface-id", "srcaddr", "dstaddr", "srcport", "dstport", "protocol", "packets", "bytes", "start", "end", "action", "log-status"]
}

# AWS > VPC > VPC > Flow Logging > S3
resource "turbot_policy_setting" "vpc_flow_logging_s3" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingS3"
  value    = "Enabled"
  # value    = "Disabled"
}

# AWS > VPC > VPC > Flow Logging > S3 > Bucket
# Uncomment the below if you want to use your own S3 Bucket.
# By default, Guardrails will use the S3 Bucket logging role created via `AWS > Turbot > Logging > Bucket` stack.

# resource "turbot_policy_setting" "vpc_flow_logging_s3_bucket" {
#   resource = turbot_smart_folder.vpc_flow_logging.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingS3Bucket"
#   value    = "<logging-bucket-name>"   # your logging bucket name
# }

# AWS > VPC > VPC > Flow Logging > S3 > Traffic Type
resource "turbot_policy_setting" "vpc_flow_logging_s3_bucket_traffic_type" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingS3TrafficType"
  value    = "Enabled"
}

# AWS > VPC > VPC > Flow Logging > S3 > Key Prefix
resource "turbot_policy_setting" "vpc_flow_logging_s3_key_bucket_prefix" {
  resource = turbot_smart_folder.vpc_flow_logging.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingS3KeyPrefix"
  value    = ""
  # value    = "turbot_"
}
