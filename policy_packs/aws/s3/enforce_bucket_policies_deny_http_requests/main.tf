resource "turbot_policy_pack" "main" {
  title       = "AWS S3 Enforce Bucket Policies Deny HTTP Requests"
  description = "Enforce that AWS S3 Bucket policies deny HTTP requests for improved security."
  akas        = ["aws_s3_enforce_bucket_policies_deny_http_requests"]
}
