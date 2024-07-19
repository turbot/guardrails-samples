# AWS > KMS > Key > Rotation
resource "turbot_policy_setting" "aws_kms_key_rotation_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
