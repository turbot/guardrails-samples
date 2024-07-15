resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM User-Managed Service Accounts to Not Have Admin Privileges"
  description = "Minimize the risk of unauthorized access and potential misuse of administrative capabilities."
}
