resource "turbot_policy_pack" "main" {
  title       = "AWS CloudWatch Enforce Log Groups Have Retention Period Specified"
  description = "Enforce that AWS CloudWatch Log Groups have a retention period specified."
  akas        = ["aws_logs_enforce_cloudwatch_log_groups_have_retention_period_specified"]
}
