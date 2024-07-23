# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# AWS > CloudTrail > Trail > Encryption at Rest
# https://turbot.com/v5/mods/turbot/aws-cloudtrail/inspect#/policy/types/trailEncryptionAtRest
resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRest"
  value    = "Check: Customer managed key"
  # Note: no Check: AWS managed key or higher available at the moment
}