resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest is Enabled for AWS EFS File Systems"
  description = "Ensure that all data stored within file systems is encrypted, protecting it from unauthorized access and potential data breaches."
  akas        = ["aws_efs_enforce_encryption_at_rest_is_enabled_for_file_systems"]
}
