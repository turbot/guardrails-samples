resource "turbot_policy_pack" "main" {
  title       = "Enforce Trusted Access for ACLs on AWS S3 Buckets"
  description = "Ensure that only authorized users and services have access to your data."
  akas        = ["aws_s3_enforce_trusted_access_for_acls_on_buckets"]
}
