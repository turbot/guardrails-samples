resource "turbot_policy_pack" "main" {
  title       = "Enforce Trusted Domains to Access GCP IAM Project Policy"
  description = "Ensure that only authorized and verified domains can interact with your project's IAM policies."
  akas        = ["gcp_iam_enforce_trusted_domains_to_access_project_iam_policy"]
}
