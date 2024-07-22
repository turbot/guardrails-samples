# GCP > Turbot > Event Handlers > Logging
resource "turbot_policy_setting" "gcp_turbot_event_handlers_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Turbot > Event Handlers > Pub/Sub
resource "turbot_policy_setting" "gcp_turbot_event_handlers_pub_sub" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}
