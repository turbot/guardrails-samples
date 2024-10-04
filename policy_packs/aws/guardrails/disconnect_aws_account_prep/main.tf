resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_disconnect_aws_account_prep"]
  title       = "Prep AWS Account for Disconnection"
  description = "Removes Guardrails-managed resources before an account disconnecting an account from Guardrails."
}
