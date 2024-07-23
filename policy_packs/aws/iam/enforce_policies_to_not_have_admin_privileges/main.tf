resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS IAM Policies to Not Have Admin Privileges"
  description = "Enforce policies to not have administrative access minimizes the risk of unauthorized access and potential misuse of administrative capabilities."
  akas        = ["aws_iam_enforce_policies_to_not_have_admin_privileges"]
}
