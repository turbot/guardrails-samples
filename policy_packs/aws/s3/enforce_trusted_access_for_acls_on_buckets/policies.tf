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

# AWS > S3 > Bucket > ACL > Trusted Access > Canonical IDs
resource "turbot_policy_setting" "aws_s3_bucket_acl_trusted_canonical_ids" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAclTrustedCanonicalIds"
  # Your trusted canonical IDs
  value    = <<-EOT
    - "1111222233334444555566667777888899990000abcd88889999008888999900"
    - "1111222233334444555566667777888899990000wxyz88889999008888999900"
    EOT
}
