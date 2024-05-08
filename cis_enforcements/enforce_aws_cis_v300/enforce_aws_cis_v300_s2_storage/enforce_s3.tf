# AWS > S3 > Bucket Policy > Deny HTTP requests
resource "turbot_policy_setting" "aws_s3_bucket_deny_http" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyHttp"
  value    = "Enforce: Deny HTTP"
  note     = "AWS CIS v3.0.0 - Control: 2.1.1"
}

# AWS > S3 > Bucket > Block Public Access
resource "turbot_policy_setting" "aws_s3_block_public_access" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/blockPublicAccessSettings"
  value    = "Enforce: Enabled"
  note     = "AWS CIS v3.0.0 - Control: 2.1.4"
}

# AWS > S3 > Bucket > Block Public Access
resource "turbot_policy_setting" "aws_s3_block_public_access" {
  resource = turbot_smart_folder.aws_cis_v300_s2_storage.id
  type     = "tmod:@turbot/aws-s3#/policy/types/blockPublicAccessSettings"
  value    = "Enforce: Enabled"
  note     = "AWS CIS v3.0.0 - Control: 2.1.4"
}



