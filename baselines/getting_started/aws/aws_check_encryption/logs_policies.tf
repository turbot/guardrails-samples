# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > Logs > Log Group > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-logs/inspect#/policy/types/logGroupEncryptionAtRest
resource "turbot_policy_setting" "cloudwatch_logs_encryption_at_rest" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-logs#/policy/types/logGroupEncryptionAtRest"
  value    = "Check: AWS SSE or higher"
}
