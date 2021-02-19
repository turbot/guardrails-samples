# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > SSM > Parameter > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-ssm/inspect#/policy/types/ssmParameterEncryptionAtRest
resource "turbot_policy_setting" "aws_ssm_param_encryption_at_rest" {
  count    = var.enable_ssm_parameter_encryption_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-ssm#/policy/types/ssmParameterEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}
