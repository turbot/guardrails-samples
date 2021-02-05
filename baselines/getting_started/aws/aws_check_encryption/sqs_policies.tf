# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > SQS > Queue > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-sqs/inspect#/policy/types/queueEncryptionAtRest
resource "turbot_policy_setting" "aws_sqs_queue_encrypted" {
  count    = enable_sqs_queue_encryption_policies ? 1 : 0  
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-sqs#/policy/types/queueEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}
