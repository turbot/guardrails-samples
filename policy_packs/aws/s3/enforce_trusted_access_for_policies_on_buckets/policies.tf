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

# AWS > S3 > Bucket > Policy > Trusted Access > Services
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_services" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedServices"
  value    = <<-EOT
    - "sns.amazonaws.com"
    - "ec2.amazonaws.com"
    EOT
}

# AWS > S3 > Bucket > Policy > Trusted Access > Identity Providers
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_identity_providers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedIdentityProviders"
  value    = <<-EOT
    - "www.acme.com"
    - "www.example.com"
    EOT
}

# AWS > S3 > Bucket > Policy > Trusted Access > Organizations
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_organizations" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedOrganizations"
  value    = <<-EOT
    - "o-333333333"
    - "o-333333444"
    EOT
}

# AWS > S3 > Bucket > Policy > Trusted Access > Organization Path Restrictions
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_organization_paths" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedOrganizationPaths"
  value    = <<-EOT
    - "o-333333333/r-wxnb/ou-wxnb-dasdtpaq/ou-*"
    - "o-444444444/r-wxnb/ou-wxnb-dfadtpaq/*"
    EOT
}

# AWS > S3 > Bucket > Policy > Trusted Access > CloudFront Origin Access Identities
resource "turbot_policy_setting" "aws_s3_bucket_policy_trusted_cloudfront_origin_access_identities" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketPolicyTrustedCloudFrontOriginAccessIdentities"
  # The expected format is an array of CloudFront OAI ARNs or OAI IDs
  value    = <<-EOT
    - "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity EH1HDMB1FH2TC"
    - "EH1HDMB1FH2TC"
    EOT
}
