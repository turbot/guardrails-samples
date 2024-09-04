resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest Is Enabled for AWS Log Groups"
  description = "Ensure that CloudWatch log groups are encrypted for enhanced security."
  akas        = ["aws_logs_enforce_encryption_at_rest_is_enabled_for_log_groups"]
}
