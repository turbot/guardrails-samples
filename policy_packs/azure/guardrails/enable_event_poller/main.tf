resource "turbot_policy_pack" "main" {
  akas        = ["azure_guardrails_enable_event_poller"]
  title       = "Enable Event Pollers For Azure Subscriptions In Guardrails"
  description = "The Guardrails Event Poller are responsible polling Audit Logs (Azure Monitor) at intervals specified and retrieves the latest events (Succeeded) for processing."
}
