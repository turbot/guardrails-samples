# GCP Real-Time Events(Pollers) 
#   https://turbot.com/v5/docs/integrations/gcp/real-time-events

# Configuring Real-Time Event Handlers
#   https://turbot.com/v5/docs/integrations/gcp/real-time-events/event-handlers

# Create Event Pollers per Project
# Note: Setting variable `use_event_polling` to false will cause the baseline to use event handlers
#       by default the baseline will use event pollers are they are the simplest setup.

# GCP > Turbot > Event Poller
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/eventPoller
resource "turbot_policy_setting" "gcp_event_polling" {
  count    = var.use_event_polling ? 1 : 0
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPoller"
  value    = "Enabled"
}

# GCP > Turbot > Event Poller > Interval
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/eventPollerInterval
resource "turbot_policy_setting" "gcp_event_polling_interval" {
  count    = var.use_event_polling ? 1 : 0
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPollerInterval"
  value    = "Every 1 minute"
}

# GCP > Turbot > Event Poller > Window
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/eventPollerWindow
resource "turbot_policy_setting" "gcp_event_pollin_window" {
  count    = var.use_event_polling ? 1 : 0
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPollerWindow"
  value    = "10 minutes"
}

# Sets the policy for Logging

# GCP > Turbot > Event Handlers > Logging
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/eventHandlersLogging
resource "turbot_policy_setting" "event_handlers_logging" {
  count    = var.use_event_polling ? 0 : 1
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  value    = "Enforce: Configured"
}

# Sets the policy for Pub/Sub
# GCP > Turbot > Event Handlers > Pub/Sub
# https://turbot.com/v5/mods/turbot/gcp/inspect#/policy/types/eventHandlersPubSub
resource "turbot_policy_setting" "event_handlers_pub_sub" {
  count    = var.use_event_polling ? 0 : 1
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  value    = "Enforce: Configured"
}

# Sets the policy Enable for API Enabled in Pub/Sub
# GCP > Pub/Sub > API Enabled
# https://turbot.com/v5/mods/turbot/gcp-pubsub/inspect#/policy/types/pubsubApiEnabled
resource "turbot_policy_setting" "pub_sub_api_enabled" {
  count    = var.use_event_polling ? 0 : 1
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp-pubsub#/policy/types/pubsubApiEnabled"
  value    = "Enforce: Enabled"
}

# Sets the policy Enable for API Enabled in Logging
# GCP > Logging > API Enabled
# https://turbot.com/v5/mods/turbot/gcp-logging/inspect#/policy/types/loggingApiEnabled
resource "turbot_policy_setting" "logging_api_enabled" {
  count    = var.use_event_polling ? 0 : 1
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp-logging#/policy/types/loggingApiEnabled"
  value    = "Enforce: Enabled"
}
