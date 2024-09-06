# AWS > VPC > VPC > Flow Logging
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  value    = "Check: Configured per `Flow Logging > *`"
  # value    = "Enforce: Configured per `Flow Logging > *`"
}

# AWS > VPC > VPC > Flow Logging > S3
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging_s3" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingS3"
  value    = "Enabled"
}

# AWS > VPC > VPC > Flow Logging > S3 > Bucket
resource "turbot_policy_setting" "aws_vpc_vpc_flow_logging_s3_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLoggingS3Bucket"
  # Your logging bucket name. Defaults to bucket name created via `AWS > Turbot > Logging > Bucket` control
  value    = "mybucket"
}
