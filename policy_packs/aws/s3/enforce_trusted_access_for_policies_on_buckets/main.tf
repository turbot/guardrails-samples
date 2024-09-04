resource "turbot_policy_pack" "main" {
  title       = "Enforce Trusted Access for Policies on AWS S3 Buckets"
  description = "Ensure that S3 bucket policies do not allow access to all AWS users or non-trusted AWS accounts for enhanced security."
  akas        = ["aws_s3_enforce_trusted_access_for_policies_on_buckets"]
}
