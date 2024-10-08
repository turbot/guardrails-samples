resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM User-Managed Service Accounts Do Not Have Admin Privileges"
  description = "Minimize the risk of unauthorized access and potential misuse of administrative capabilities."
  akas        = ["gcp_iam_enforce_user_service_accounts_do_not_have_admin_privileges"]
}
