# GCP > Turbot > Event Handlers > Logging
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Turbot > Event Handlers > Pub/Sub
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}