resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Account Organization Name Display"
  description = "Automatically set AWS account aliases using organization account names for accounts that are part of an AWS organization."
  akas        = ["aws_guardrails_enforce_account_organization_name_display"]
}
