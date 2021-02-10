# Create Event Pollers per subscription
# Azure > Turbot > Event Pollers
# Note: could consider event handlers, however for getting started, event pollers are the simplest setup
# More Info: https://turbot.com/v5/docs/integrations/azure/real-time-events/event-pollers

resource "turbot_policy_setting" "azure_event_polling" {
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure#/policy/types/eventPoller"
  value    = "Enabled"
}

resource "turbot_policy_setting" "azure_event_polling_interval" {
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure#/policy/types/eventPollerInterval"
  value    = "Every 1 minute"
}

resource "turbot_policy_setting" "azure_event_pollin_window" {
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure#/policy/types/eventPollerWindow"
  value    = "10 minutes"
}
