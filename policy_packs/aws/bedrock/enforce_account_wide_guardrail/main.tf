resource "turbot_policy_pack" "main" {
  title       = "Enforce Account-Wide Guardrail for AWS Bedrock"
  description = "Require an account-level enforced guardrail configuration so a Bedrock guardrail is applied to every in-region model invocation regardless of caller behavior."
  akas        = ["aws_bedrock_enforce_account_wide_guardrail"]
}
