resource "turbot_policy_pack" "main" {
  title       = "AWS CloudFront Enforce Logging Is Enabled for Distributions"
  description = "Enforce that AWS CloudFront distribution logging is enabled."
  akas        = ["aws_cloudfront_enforce_logging_is_enabled_for_cloudfront_distributions"]
}
