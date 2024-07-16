# AWS > S3 > Bucket > Policy > Trusted Access
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedAccess"
  value    = "Check: Trusted Access"
  # value    = "Enforce: Revoke untrusted access"
}

# AWS > S3 > Bucket > Policy > Trusted Access > Accounts
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_accounts" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedAccounts"
  value    = <<-EOT
    - "123456789012"
    - "123456789013"
    EOT
}
