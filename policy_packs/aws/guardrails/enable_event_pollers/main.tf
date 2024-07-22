resource "turbot_policy_pack" "main" {
  akas        = ["aws_guardrails_enable_event_pollers"]
  title       = "Enable Event Pollers for AWS Regions in Guardrails"
  description = "The Guardrails Event Pollers are responsible for conveying events from AWS CloudTrail back to Guardrails for processing. This is a requirement for Guardrails to process relevant events on a schedule, and forward them to the router for further processing."
}
