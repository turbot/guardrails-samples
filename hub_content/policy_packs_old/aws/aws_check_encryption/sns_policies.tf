# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > SNS > Topic > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-sns/inspect#/policy/types/topicEncryptionAtRest
resource "turbot_policy_setting" "aws_sns_topic_encrypted" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-sns#/policy/types/topicEncryptionAtRest"
  value    = "Check: AWS managed key or higher"
}
