# AWS > Turbot > Event Handlers
resource "turbot_policy_setting" "aws_turbot_event_handlers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlers"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}