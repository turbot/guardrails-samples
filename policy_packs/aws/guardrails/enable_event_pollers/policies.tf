# AWS > Turbot > Event Poller
resource "turbot_policy_setting" "aws_turbot_event_poller" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventPoller"
  value    = "Enabled"
}

# AWS > Turbot > Event Poller > Interval
resource "turbot_policy_setting" "aws_turbot_event_poller_interval" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventPollerInterval"
  value    = "Every 2 minutes"
}

# AWS > Turbot > Event Poller > Interval > Window
resource "turbot_policy_setting" "aws_turbot_event_poller_interval_window" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventPollerWindow"
  value    = "15 minutes"
}
