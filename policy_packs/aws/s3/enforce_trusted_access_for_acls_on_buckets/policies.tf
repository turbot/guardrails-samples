# AWS > S3 > Bucket > ACL > Trusted Access
resource "turbot_policy_setting" "aws_s3_bucket_acl_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAclTrustedAccess"
  value    = "Check: Trusted Access"
  # value    = "Enforce: Revoke untrusted access"
}

# AWS > S3 > Bucket > ACL > Trusted Access > Groups
resource "turbot_policy_setting" "aws_s3_bucket_acl_trusted_groups" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAclTrustedGroups"
  value    = <<-EOT
    - AuthenticatedUsers
    - LogDelivery
    EOT
}
