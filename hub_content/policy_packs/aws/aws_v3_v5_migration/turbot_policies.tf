# AWS > Account > Approved Regions [Default]
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/approvedRegionsDefault
resource "turbot_policy_setting" "aws_approved_regions" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/approvedRegionsDefault"
  value    = yamlencode(var.aws_approved_regions)
  count    = var.aws_approved_regions != null ? 1 : 0
}

// AWS > Turbot > Event Handlers
// https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/eventHandlers
resource "turbot_policy_setting" "turbot_event_handlers_enabled" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlers"
  value    = "Enforce: Configured"
  count    = var.event_handlers_enabled ? 1 : 0
}

# AWS > Turbot > Event Handlers > Events > Rules > Name Prefix
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/eventHandlersEventsRulesNamePrefix
resource "turbot_policy_setting" "turbot_event_rule_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersEventsRulesNamePrefix"
  value    = var.event_handlers_prefix
  count    = var.event_handlers_enabled && var.event_handlers_prefix != null ? 1 : 0
}

# AWS > Turbot > Event Handlers > SNS > Topic > Name Prefix
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/eventHandlersSnsTopicNamePrefix
resource "turbot_policy_setting" "turbot_event_topic_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersSnsTopicNamePrefix"
  value    = var.event_handlers_prefix
  count    = var.event_handlers_enabled && var.event_handlers_prefix != null ? 1 : 0
}

# AWS > Turbot > Logging > Bucket
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/loggingBucket
resource "turbot_policy_setting" "turbot_logging_buckets" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  value    = "Enforce: Configured"
  count    = var.logging_buckets ? 1 : 0
}

# AWS > Turbot > Logging > Bucket > Name > Prefix
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/loggingBucketNamePrefix
resource "turbot_policy_setting" "turbot_logging_buckets_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucketNamePrefix"
  value    = var.logging_bucket_prefix
  count    = var.logging_buckets && var.logging_bucket_prefix != null ? 1 : 0
}

# AWS > Turbot > Audit Trail
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/auditTrail
resource "turbot_policy_setting" "turbot_cloudtrail_enabled" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  value    = "Enforce: Configured"
  count    = var.turbot_cloudtrails ? 1 : 0
}

# AWS > Turbot > Audit Trail
# https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/auditTrailTrailNamePrefix
resource "turbot_policy_setting" "turbot_cloudtrail_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrailTrailNamePrefix"
  value    = var.turbot_cloudtrails_prefix
  count    = var.turbot_cloudtrails && var.turbot_cloudtrails_prefix != null ? 1 : 0
}
