# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > DynamoDB > Table > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-dynamodb/inspect#/policy/types/tableEncryptionAtRest
resource "turbot_policy_setting" "aws_dynamodb_table_encryption_at_rest" {
  count    = var.enable_dynamodb_table_encryption_policies ? 1 : 0
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-dynamodb#/policy/types/tableEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}