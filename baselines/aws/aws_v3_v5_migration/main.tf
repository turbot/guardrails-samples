resource "turbot_smart_folder" "turbot_event_handlers_folder" {
  title = "Event Handlers v3 v5 Migration"
  description = "Policies for Enabling the Turbot Event Handlers"
  parent = "tmod:@turbot/turbot#/"
}

// https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/eventHandlers
resource "turbot_policy_setting" "turbot_event_handlers_enabled" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/eventHandlers"
  value = "Enforce: Configured"
  count = var.event_handlers_enabled ? 1 : 0
}

//value should end with an underscore. The default is 'turbot_'.
resource "turbot_policy_setting" "turbot_event_rule_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/eventHandlersEventsRulesNamePrefix"
  value = var.event_handlers_prefix
  count = var.event_handlers_enabled ? 1 : 0
}

//value should end with an underscore. The default is 'turbot_'.
resource "turbot_policy_setting" "turbot_event_topic_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/eventHandlersSnsTopicNamePrefix"
  value = var.event_handlers_prefix
  count = var.event_handlers_enabled ? 1 : 0
}

// https://turbot.com/v5/mods/turbot/aws/inspect#/policy/types/eventHandlers
resource "turbot_policy_setting" "turbot_logging_buckets" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/loggingBucket"
  value = "Enforce: Configured"
  count = var.logging_buckets ? 1 : 0
}

// There isn't much chance of a name collision on logging buckets.  This is provided for completeness.
// Should end with a dash '-'.  Default value is 'turbot-'.
resource "turbot_policy_setting" "turbot_logging_buckets_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/loggingBucketNamePrefix"
  value = var.logging_bucket_prefix
  count = var.logging_buckets ? 1 : 0
}

resource "turbot_policy_setting" "turbot_cloudtrail_enabled" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/auditTrail"
  value = "Enforce: Configured"
  count = var.turbot_cloudtrails ? 1 : 0
}

//Only enable this if you don't already have a CloudTrail.
resource "turbot_policy_setting" "turbot_cloudtrail_prefix" {
  resource = turbot_smart_folder.turbot_event_handlers_folder.id
  type = "tmod:@turbot/aws#/policy/types/auditTrailTrailNamePrefix"
  value = var.turbot_cloudtrails_prefix
  count = var.turbot_cloudtrails ? 1 : 0
}

