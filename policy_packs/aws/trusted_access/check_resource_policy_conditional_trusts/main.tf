resource "turbot_policy_pack" "main" {
  title       = "Check Resource Policy Conditional Trusts for AWS Services"
  description = "Check that AWS resource policies have appropriate conditional trust relationships to prevent unauthorized access."
  akas        = ["aws_check_resource_policy_conditional_trusts"]
}