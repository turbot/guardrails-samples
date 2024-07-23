resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_regions"]
  title       = "Enable Regions for AWS Accounts in Guardrails"
  description = "The Guardrails Regions for AWS Accounts in which resources are recorded."
}
