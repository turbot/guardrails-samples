# AWS > KMS > Key > Rotation
resource "turbot_policy_setting" "aws_kms_key_rotation" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  note     = "AWS CIS v3.0.0 - Controls: 3.6"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
