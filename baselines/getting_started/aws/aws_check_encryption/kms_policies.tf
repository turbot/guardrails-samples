# Related: KMS related to AWS CIS 2.08 Ensure rotation for customer created CMKs is enabled

# AWS > KMS > Key > Rotation
# https://turbot.com/v5/mods/turbot/aws-kms/inspect#/policy/types/keyRotation
resource "turbot_policy_setting" "keyRotation" {
  resource = turbot_smart_folder.aws_encryption.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  value    = "Check: Enabled"
}
