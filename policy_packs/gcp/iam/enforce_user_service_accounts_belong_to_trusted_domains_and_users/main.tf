resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM Service-Accounts Belong To Trusted Domains And Users"
  description = "Enforce service accounts belong to trusted domains and users mitigates the risk of unauthorized access, data breaches, and malicious activities by ensuring that service accounts are managed within a secure and trusted environment."
  akas        = ["gcp_iam_enforce_user_service_accounts_belong_to_trusted_domains_and_users"]
}
