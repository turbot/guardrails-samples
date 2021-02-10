# Setting Resource Schedules to start/stop based on schedule
# Set to Skip to avoid accidently Enforcement.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/scheduling


# Policy Setting Options:
# Skip
# Enforce: Business hours (8:00am - 6:00pm on weekdays)
# Enforce: Extended business hours (7:00am - 11:00pm on weekdays)
# Enforce: Stop for night (stop at 10:00pm every day)
# Enforce: Stop for weekend (stop at 10:00pm on Friday)

## Compute Engine Instance Instances
resource "turbot_policy_setting" "gcp_computeengine_instance_schedule" {
  resource = turbot_smart_folder.gcp_cost_controls.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSchedule"
  value    = "Skip"
}

# # Schedule Tag Option, more information https://turbot.com/v5/docs/concepts/guardrails/scheduling#scheduling-with-a-tag
# resource "turbot_policy_setting" "gcp_computeengine_instance_schedule_tag" {
# resource = turbot_smart_folder.gcp_cost_controls.id
#  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceScheduleTag"
#  value    = "Skip" 
            # "Enforce: Schedule per turbot_custom_schedule tag"