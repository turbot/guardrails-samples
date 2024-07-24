resource "turbot_policy_pack" "main" {
  title       = "Enforce Rotation Is Enabled on AWS KMS Keys"
  description = "Ensuring that keys are rotated minimizes the risk of key compromise and limits the potential impact of a security breach."
  akas        = ["aws_kms_enforce_rotation_is_enabled_for_keys"]
}
