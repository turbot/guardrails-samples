# Simple cost control to check for aging infrastructure over X days
# Defaulting to 60 days as an example.
# Other use cases can be used for Last Modified, Attached, etc.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/active

# Azure > Compute > Virtual Machine > Active
# https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/virtualMachineActive
resource "turbot_policy_setting" "set_resource_active_policies" {
  for_each        = var.resource_active
  resource        = turbot_smart_folder.azure_cost_controls.id
  type            = local.policy_map[each.key]
  value           = each.value
}

# Azure > Compute > Virtual Machine > Active > Age
# https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/virtualMachineActiveAge
resource "turbot_policy_setting" "set_resource_age_policies" {
  for_each        = var.resource_active
  resource        = turbot_smart_folder.azure_cost_controls.id
  type            = local.policy_map_age[each.key]
  value           = "Force inactive if age > 60 days"
                    # Skip
                    # Force inactive if age > 1 day
                    # Force inactive if age > 3 days
                    # Force inactive if age > 7 days
                    # Force inactive if age > 14 days
                    # Force inactive if age > 30 days
                    # Force inactive if age > 60 days
                    # Force inactive if age > 90 days
                    # Force inactive if age > 180 days
                    # Force inactive if age > 365 days
}

# Azure > Compute > Disk > Active
# https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/diskActive
resource "turbot_policy_setting" "azure_disk_active" {
  resource = turbot_smart_folder.azure_cost_controls.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskActive"
  value    = "Check: Active"
}

# Azure > Compute > Disk > Active > Attached
# https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/diskActiveAttached
resource "turbot_policy_setting" "azure_disk_active_attached" {
  resource = turbot_smart_folder.azure_cost_controls.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskActiveAttached"
  value    = "Force inactive if unattached"
}