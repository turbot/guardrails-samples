resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS KMS Keys Allow Only Approved Action Permissions"
  description = "Ensure that only authorized actions can be performed on KMS keys, reducing the risk of unauthorized access and misuse, thereby enhancing overall security and compliance with best practices."
  akas        = ["aws_kms_enforce_keys_to_not_allow_unapproved_action_permissions"]
}
