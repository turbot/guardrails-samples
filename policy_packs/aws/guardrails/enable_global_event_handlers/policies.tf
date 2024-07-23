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
# # By default, this policy is set via the `AWS > Turbot > Service Roles > Event Handlers [Global]` policy, but can be overwritten if needed.
# resource "turbot_policy_setting" "aws_turbot_event_handlers_global_events_target_iam_role_arn" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws#/policy/types/eventHandlersGlobalEventsTargetIamRoleArn"
#   value    = "arn:aws:iam::123456789012:role/my-role"
# }
