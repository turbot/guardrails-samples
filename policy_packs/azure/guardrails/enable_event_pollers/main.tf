resource "turbot_policy_pack" "main" {
  akas        = ["azure_guardrails_enable_event_pollers"]
  title       = "Enable Event Pollers for Azure Subscriptions in Guardrails"
  description = "The Guardrails Event Pollers are responsible for conveying relevant events from Azure Activity Log back to Guardrails on a schedule, and forward them to the router for further processing."
}
