resource "turbot_policy_pack" "main" {
  akas        = ["gcp_guardrails_enable_event_poller"]
  title       = "Enable Event Poller For GCP Projects In Guardrails"
  description = "The Guardrails Event Poller are responsible polling GCP Logging at intervals specified and retrieves the latest events for processing."
}
