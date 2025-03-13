resource "turbot_policy_pack" "main" {
  title       = "AWS Secrets Manager Enforce Automatic Rotation Is Enabled for Secrets"
  description = "Enforce that AWS Secrets Manager has automatic rotation enabled for secrets."
  akas        = ["aws_secretsmanager_enforce_automatic_rotation_is_enabled_for_secrets"]
}
