resource "turbot_policy_pack" "main" {
  title       = "Enforce CloudFront Distribution for AWS S3 Buckets Is Secured"
  description = "Ensure that security best practices, such as HTTPS and access controls are applied to CloudFront distributions, reducing the risk of unauthorized access and data breaches."
  akas        = ["aws_s3_enforce_cloudfront_distribution_for_buckets_is_secured"]
}
