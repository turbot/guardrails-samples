resource "turbot_policy_pack" "main" {
  title       = "Check GCP IAM Users Belong To Approved Domains"
  description = "Ensures that users belong to approved domains, reducing the risk of unauthorized access, data breaches, and malicious activities by ensuring that user accounts are managed within a secure and trusted environment."
  akas        = ["gcp_iam_enforce_project_user_belong_to_approved_domains"]
}
