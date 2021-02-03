# Create Event Pollers per Project
# GCP > Turbot > Event Pollers
# More Info on Pollers: https://turbot.com/v5/docs/integrations/gcp/real-time-events

# Note: could consider event handlers, however for getting started, event pollers are the simplest setup
# More Info: https://turbot.com/v5/docs/integrations/gcp/real-time-events/event-handlerss

resource "turbot_policy_setting" "gcp_event_polling" {
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPoller"
  value    = "Enabled"
}

resource "turbot_policy_setting" "gcp_event_polling_interval" {
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPollerInterval"
  value    = "Every 1 minute"
}

# GCP > Turbot > Event Poller > Window
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/eventPollerWindow
resource "turbot_policy_setting" "gcp_event_pollin_window" {
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPollerWindow"
  value    = "10 minutes"
}


# Replace above section with this if realtime events are required over polling

# # Sets the policy for Logging
# # GCP > Turbot > Event Handlers > Logging
# resource "turbot_policy_setting" "eventHandlersLogging" {
#   resource    = turbot_smart_folder.gcp_baseline.id
#   type        = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
#   value       = "Enforce: Configured"
# }

# # Sets the policy for Pub/Sub
# # GCP > Turbot > Event Handlers > Pub/Sub
# resource "turbot_policy_setting" "eventHandlersPubSub" {
#   resource    = turbot_smart_folder.gcp_baseline.id
#   type        = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
#   value       = "Enforce: Configured"
# }

# # Sets the policy Enable for API Enabled in Pub/Sub
# # GCP > Pub/Sub > API Enabled
# # This maybe already set in the baseline can stay commented out if so
# resource "turbot_policy_setting" "pubsubApiEnabled" {
#   resource    = turbot_smart_folder.gcp_baseline.id
#   type        = "tmod:@turbot/gcp-pubsub#/policy/types/pubsubApiEnabled"
#   value       = "Enforce: Enabled"
# }

# # Sets the policy Enable for API Enabled in Logging
# # GCP > Logging > API Enabled
# This maybe already set in the baseline can stay commented out if so
# resource "turbot_policy_setting" "loggingApiEnabled" {
#   resource    = turbot_smart_folder.gcp_baseline.id
#   type        = "tmod:@turbot/gcp-logging#/policy/types/loggingApiEnabled"
#   value       = "Enforce: Enabled"
# }
