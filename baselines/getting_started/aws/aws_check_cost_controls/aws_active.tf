# Simple cost control to check for aging infrastructure over X days
# Defaulting to 60 days as an example.
# Other use cases can be used for Last Modified, Attached, etc.
# More Info: https://turbot.com/v5/docs/concepts/guardrails/active

# AWS > EC2 > Instance > Active
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceActive
# Loop through var.service_status to enable the Age policies
resource "turbot_policy_setting" "set_resource_active_policies" {
  for_each        = var.resource_active
  resource        = turbot_smart_folder.aws_cost_controls.id
  type            = var.policy_map[each.key]
  value           = each.value
}

# AWS > EC2 > Instance > Active > Age
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceActiveAge
resource "turbot_policy_setting" "set_resource_age_policies" {
  for_each        = var.resource_active
  resource        = turbot_smart_folder.aws_cost_controls.id
  type            = var.policy_map_age[each.key]
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

# AWS > EC2 > Volume > Active
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/volumeActive
# Specific EC2 Volume Active controls focused on unnatached vs Age
resource "turbot_policy_setting" "aws_ec2_volume_active" {
  resource = turbot_smart_folder.aws_cost_controls.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActive"
  value    = "Check: Active"
}

# AWS > EC2 > Volume > Active > Attached
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/volumeActiveAttached
resource "turbot_policy_setting" "aws_ec2_volume_active_attached" {
  resource = turbot_smart_folder.aws_cost_controls.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActiveAttached"
  value    = "Force inactive if unattached"
}

# # AWS > EC2 > Instance > Active
# # https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbClusterActive
# # Loop through var.service_status to enable the Age policies
# resource "turbot_policy_setting" "set_resource_active_policies" {
#   for_each        = var.resource_active
#   resource        = turbot_smart_folder.aws_cost_controls.id
#   type            = var.policy_map[each.key]
#   value           = each.value
# }

# # AWS > RDS > DB Cluster > Active
# # https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceActiveAge
# resource "turbot_policy_setting" "set_resource_age_policies" {
#   for_each        = var.resource_active
#   resource        = turbot_smart_folder.aws_cost_controls.id
#   type            = var.policy_map_age[each.key]
#   value           = "Force inactive if age > 60 days"
#                     # Skip
#                     # Force inactive if age > 1 day
#                     # Force inactive if age > 3 days
#                     # Force inactive if age > 7 days
#                     # Force inactive if age > 14 days
#                     # Force inactive if age > 30 days
#                     # Force inactive if age > 60 days
#                     # Force inactive if age > 90 days
#                     # Force inactive if age > 180 days
#                     # Force inactive if age > 365 days
# }

# # AWS > EC2 > Volume > Active
# # https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/volumeActive
# # Specific EC2 Volume Active controls focused on unnatached vs Age
# resource "turbot_policy_setting" "aws_ec2_volume_active" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActive"
#   value    = "Check: Active"
# }

# # AWS > EC2 > Volume > Active > Attached
# # https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/volumeActiveAttached
# resource "turbot_policy_setting" "aws_ec2_volume_active_attached" {
#   resource = turbot_smart_folder.aws_cost_controls.id
#   type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActiveAttached"
#   value    = "Force inactive if unattached"
# }