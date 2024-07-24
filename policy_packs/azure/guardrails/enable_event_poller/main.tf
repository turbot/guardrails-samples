resource "turbot_policy_pack" "main" {
  title       = "Enable Event Pollers for Azure Subscriptions"
  description = "The Guardrails Event Poller are responsible polling Audit Logs (Azure Monitor) at intervals specified and retrieves the latest events (Succeeded) for processing."
  akas        = ["azure_guardrails_enable_event_poller"]
}
