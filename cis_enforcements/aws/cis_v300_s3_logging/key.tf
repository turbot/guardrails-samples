# AWS > KMS > Key > Rotation
resource "turbot_policy_setting" "aws_kms_key_rotation" {
  resource = turbot_smart_folder.aws_cis_v300_s3_logging.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  note     = "AWS CIS v3.0.0 - Controls: 3.06"
  value    = "Check: Enabled"
  # value = "Enforce: Enabled"
}
