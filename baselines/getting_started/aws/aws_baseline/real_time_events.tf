# Create Event Handlers as per the Region Defaults
# AWS > Turbot > Event Handlers
# More information: https://turbot.com/v5/docs/integrations/aws/event-handlers

resource "turbot_policy_setting" "eventHandlers" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlers"
  value    = "Enforce: Configured"
}
