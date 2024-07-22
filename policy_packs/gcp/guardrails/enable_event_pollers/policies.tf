# GCP > Turbot > Event Poller
resource "turbot_policy_setting" "gcp_turbot_event_poller" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPoller"
  value    = "Enabled"
}

# GCP > Turbot > Event Poller > Interval
resource "turbot_policy_setting" "gcp_turbot_event_poller_interval" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPollerInterval"
  value    = "Every 1 minute"
}

# GCP > Turbot > Event Poller > Interval > Window
resource "turbot_policy_setting" "gcp_turbot_event_poller_interval_window" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventPollerWindow"
  value    = "5 minutes"
}
