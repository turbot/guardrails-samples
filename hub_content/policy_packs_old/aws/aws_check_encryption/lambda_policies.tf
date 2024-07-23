# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > Lambda > Function > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-lambda/inspect#/policy/types/functionEncryptionAtRest
resource "turbot_policy_setting" "lambda_function_ennvar_encryption_at_rest" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}
