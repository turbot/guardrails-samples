resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM Project Policy Belong to Trusted Domains"
  description = "Enforce project policy belong to trusted domains ensures that only verified and authorized domains can define and manage IAM policies, reducing the risk of unauthorized access and potential security breaches."
  akas        = ["gcp_iam_enforce_project_policy_belong_to_trusted_domains"]
}
