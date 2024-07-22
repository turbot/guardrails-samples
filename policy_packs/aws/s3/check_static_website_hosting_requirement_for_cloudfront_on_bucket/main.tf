resource "turbot_policy_pack" "main" {
  title       = "Check Static Website Hosting Requirement for CloudFront on Bucket"
  description = "Ensure that static website hosting on S3 buckets requires CloudFront for enhanced security and performance."
  akas        = ["aws_s3_check_static_website_hosting_requirement_for_cloudfront_on_bucket"]
}