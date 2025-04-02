resource "turbot_policy_pack" "main" {
  title       = "AWS Secrets Manager Enforce Unused Secrets Are Removed After 90 Days"
  description = "Enforce that AWS Secrets Manager secrets unused for 90 days or more are removed."
  akas        = ["aws_secretsmanager_enforce_unused_secrets_are_removed_after_90_days"]
}
