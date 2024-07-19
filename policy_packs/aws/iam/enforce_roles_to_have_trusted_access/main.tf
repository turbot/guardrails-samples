resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS IAM Roles To Have Trusted Access"
  description = "This measure restricts role assumption to trusted accounts and services, reducing the risk of unauthorized access, enhancing security, and ensuring compliance with organizational policies."
  akas        = ["aws_iam_enforce_roles_to_have_trusted_access"]
}
