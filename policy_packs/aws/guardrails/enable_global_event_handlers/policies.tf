# AWS > Turbot > Event Handlers [Global]
resource "turbot_policy_setting" "aws_turbot_event_handlers_global" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersGlobal"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Event Handlers [Global] > Primary Region
resource "turbot_policy_setting" "aws_turbot_event_handlers_global_primary_region" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersGlobalPrimaryRegion"
  value    = "us-east-1"
  # value    = "us-gov-west-1"
  # value    = "cn-north-1"
}

# # AWS > Turbot > Event Handlers [Global] > Events > Target > IAM Role ARN
# # The IAM Role used to forward events from the non-primary regions to the primary region.
# # This policy is used when the Global Event Handler IAM Role is deployed some other way than the Service Roles control.
# resource "turbot_policy_setting" "aws_turbot_event_handlers_global_events_target_iam_role_arn" {
#   resource = turbot_policy_pack.main.id
#   type           = "tmod:@turbot/aws#/policy/types/eventHandlersGlobalEventsTargetIamRoleArn"
#   template_input = <<-EOT
#     {
#       account
#       {
#         # Look for the name of the EventBridge IAM role.
#         event_bridge_role: children(filter:"$.RoleName:'guardrails_eventbridge_role'"){
#           role:items
#           {
#             akas
#           }
#         }
#       }
#     }
#   EOT
#   template       = <<-EOT
#     {% if $.account.event_bridge_role.role | length == 1 -%}
#     {{ $.account.event_bridge_role.role[0].akas[0] }}
#     {% else -%}
#     {#  if something weird happens, the GEH control will go into `invalid` because the ARN isn't wellformed. #}
#     "missing or too many eventbridge roles"
#     {% endif -%}
#   EOT
# }

# AWS > Turbot > Service Roles
resource "turbot_policy_setting" "aws_service_roles" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRoles"
  value    = "Check: Configured"
  #  value    = "Enforce: Configured"
}

# AWS > Turbot > Service Roles > SSM Notifications
# # Enabled by default.  Not required for Global Event Handler deployment.
resource "turbot_policy_setting" "aws_service_roles_ssm_notifications" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesSsmNotifications"
  value    = "Disabled"
}

# AWS > Turbot > Service Roles > Event Handlers [Global]
# # Disabled by default.  Required for Global Event Handler deployment.
resource "turbot_policy_setting" "aws_service_roles_event_handlers_global" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesEventHandlersGlobal"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > Configuration Recording
# # Enabled by default.  Not required for Global Event Handler deployment.
resource "turbot_policy_setting" "aws_service_roles_configuration_recording" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesConfigurationRecording"
  value    = "Disabled"
}

# AWS > Turbot > Service Roles > Default EC2 Instance
# # Enabled by default.  Not required for Global Event Handler deployment.
resource "turbot_policy_setting" "aws_service_roles_default_ec2_instance" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesDefaultEc2Instance"
  value    = "Disabled"
}

# AWS > Turbot > Service Roles > Flow Logging
# # Enabled by default.  Not required for Global Event Handler deployment.
resource "turbot_policy_setting" "aws_service_roles_flow_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesFlowLogging"
  value    = "Disabled"
}

