# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > SSM > Parameter > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-ssm/inspect#/policy/types/ssmParameterEncryptionAtRest
resource "turbot_policy_setting" "secrets_manager_encryption_at_rest" {
  count    = enable_secretmanager_secret_encryption_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}