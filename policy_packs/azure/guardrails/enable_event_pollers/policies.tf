# Azure > Turbot > Event Poller
resource "turbot_policy_setting" "azure_turbot_event_poller" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure#/policy/types/eventPoller"
  value    = "Enabled"
}

# Azure > Turbot > Event Poller > Interval
resource "turbot_policy_setting" "azure_turbot_event_poller_interval" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure#/policy/types/eventPollerInterval"
  value    = "Every 1 minute"
}

# Azure > Turbot > Event Poller > Interval > Window
resource "turbot_policy_setting" "azure_turbot_event_poller_interval_window" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure#/policy/types/eventPollerWindow"
  value    = "10 minutes"
}
