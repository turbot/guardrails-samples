resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable Specific Permissions On AWS KMS Keys"
  description = "Ensures that only authorized users and applications can access and manage encryption keys."
  akas        = ["aws_kms_enforce_enable_specific_permissions_on_keys"]
}
