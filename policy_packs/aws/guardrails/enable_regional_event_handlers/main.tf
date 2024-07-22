resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_regional_event_handlers"]
  title       = "Enable Regional Event Handlers for AWS Accounts in Guardrails"
  description = "The Guardrails Event Handlers are responsible for conveying events from AWS CloudTrail back to Guardrails for processing. This is a requirement for Guardrails to process and respond in real-time."
}
