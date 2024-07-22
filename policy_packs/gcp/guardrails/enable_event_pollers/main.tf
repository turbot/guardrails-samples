resource "turbot_policy_pack" "main" {
  akas        = ["gcp_guardrails_enable_event_pollers"]
  title       = "Enable Event Pollers for GCP Projects in Guardrails"
  description = "The Guardrails Event Pollers are responsible for conveying relevant events from GCP Monitor back to Guardrails on a schedule, and forward them to the router for further processing."
}
