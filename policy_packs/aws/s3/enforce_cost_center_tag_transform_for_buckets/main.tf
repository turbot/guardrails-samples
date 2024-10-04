resource "turbot_policy_pack" "main" {
  title       = "Enforce Cost Center Tag Transform for AWS S3 Buckets"
  description = "Enforcing a consistent format for the `Cost_Center` tag key ensures that all tags are uniform, helping to keep resources organized and making tracking and management easier."
  akas        = ["aws_s3_enforce_cost_center_tag_transform_for_buckets"]
}
