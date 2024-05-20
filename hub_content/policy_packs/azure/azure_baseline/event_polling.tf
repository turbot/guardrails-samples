# Create Event Pollers per subscription
# Note: You can consider event handlers, however for getting started, event pollers are the simplest setup
# More Info: https://turbot.com/v5/docs/integrations/azure/real-time-events/event-pollers

# Azure > Turbot > Event Poller
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/eventPoller
resource "turbot_policy_setting" "azure_event_polling" {
  count    = var.enable_azure_event_polling ? 1 : 0
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure#/policy/types/eventPoller"
  value    = "Enabled"
}

# Azure > Turbot > Event Poller > Interval
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/eventPollerInterval
resource "turbot_policy_setting" "azure_event_polling_interval" {
  count    = var.enable_azure_event_polling_interval ? 1 : 0
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure#/policy/types/eventPollerInterval"
  value    = "Every 1 minute"
}

# Azure > Turbot > Event Poller > Window
# https://turbot.com/v5/mods/turbot/azure/inspect#/policy/types/eventPollerWindow
resource "turbot_policy_setting" "azure_event_polling_window" {
  count    = var.enable_azure_event_polling_window ? 1 : 0
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure#/policy/types/eventPollerWindow"
  value    = "10 minutes"
}
