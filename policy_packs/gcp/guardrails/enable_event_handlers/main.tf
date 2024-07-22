resource "turbot_policy_pack" "main" {
  akas        = ["gcp_guardrails_enable_event_handlers"]
  title       = "Enable Event Handlers for GCP Projects in Guardrails"
  description = "The Guardrails Event Handlers are responsible for conveying events from GCP Logging back to Guardrails for processing. This is a requirement for Guardrails to process and respond in real-time."
}
