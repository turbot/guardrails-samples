resource "turbot_policy_pack" "main" {
  title       = "AWS IAM Enforce Resource Policies with Allow Have Conditions"
  description = "Enforce that AWS IAM Resource Policies with 'Allow' effect have conditions from the listed conditions."
  akas        = ["aws_iam_enforce_iam_resource_policies_with_allow_have_conditions"]
}
