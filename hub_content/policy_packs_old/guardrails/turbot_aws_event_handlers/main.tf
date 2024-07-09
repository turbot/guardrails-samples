# Create smart folder for policies
resource "turbot_smart_folder" "turbot_aws_event_handlers" {
    title       = var.smart_folder_title
    description = "Create Turbot AWS Event Handlers"
    parent      = "tmod:@turbot/turbot#/"
}

# This stack configures the cloudwatch and SNS resources required for Turbot real-time event routing.
# AWS > Turbot > Event Handlers

resource "turbot_policy_setting" "turbot_aws_eventhandlers" {
    resource = turbot_smart_folder.turbot_aws_event_handlers.id
    type = "tmod:@turbot/aws#/policy/types/eventHandlers"
    value = "Enforce: Configured"
}