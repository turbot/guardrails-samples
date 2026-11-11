resource "turbot_policy_pack" "main" {
  title       = "Check If MFA Is Enabled for OCI IAM Users"
  description = "Reduce the risk of account takeover by alarming on IAM users who can sign in to the console without multi-factor authentication."
  akas        = ["oci_iam_check_mfa_is_enabled_for_users"]
}
