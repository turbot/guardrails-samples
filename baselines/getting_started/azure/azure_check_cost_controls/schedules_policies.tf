# Setting Resource Schedules to start/stop based on schedule
# Set to Skip to avoid accidently Enforcement.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/scheduling


# Policy Setting Options:
# Skip
# Enforce: Business hours (8:00am - 6:00pm on weekdays)
# Enforce: Extended business hours (7:00am - 11:00pm on weekdays)
# Enforce: Stop for night (stop at 10:00pm every day)
# Enforce: Stop for weekend (stop at 10:00pm on Friday)

## Azure VM Instances
# Azure > Compute > Virtual Machine > Schedule
# https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/virtualMachineSchedule
resource "turbot_policy_setting" "vm_instance_schedule" {
  resource = turbot_smart_folder.azure_cost_controls.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineSchedule"
  value    = "Skip"
}

# # Schedule Tag Option, more information https://turbot.com/v5/docs/concepts/guardrails/scheduling#scheduling-with-a-tag
# # Azure > Compute > Virtual Machine > Schedule Tag
# # https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/virtualMachineScheduleTag
# resource "turbot_policy_setting" "aws_vm_instance_schedule_tag" {
# resource = turbot_smart_folder.azure_cost_controls.id
#  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineScheduleTag"
#  value    = "Skip" 
            # "Enforce: Schedule per turbot_custom_schedule tag"