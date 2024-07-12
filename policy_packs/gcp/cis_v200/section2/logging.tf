# GCP > Turbot > Event Handlers > Logging
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Turbot > Event Handlers > Logging > Unique Writer Identity
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging_unique_writer_identity" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLoggingUniqueWriterIdentity"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "Enforce: Default Service Account"
  # value    = "Enforce: Unique Identity"
}

# GCP > Turbot > Event Handlers > Logging > Sink > Name Prefix
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging_sink_name_prefix" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerLoggingSinkNamePrefix"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "myLoggingSinkNamePrefix"
  # value    = "_turbot"
}

# GCP > Turbot > Event Handlers > Logging > Sink > Destination Topic
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging_sink_destination_topic" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerLoggingSinkDestinationTopic"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  value    = "pubsub.googleapis.com/projects/myProjectId/topics/myTopicId"
}

# GCP > Turbot > Event Handlers > Pub/Sub
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# GCP > Turbot > Event Handlers > Pub/Sub > Topic > Name Prefix
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub_topic_name_prefix" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerPubSubTopicNamePrefix"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "myPubSubTopicNamePrefix"
  # value    = "_turbot"
}

# GCP > Turbot > Event Handlers > Pub/Sub > Subscription > Name Prefix
resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub_subscription_name_prefix" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlerPubSubSubscriptionNamePrefix"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  value    = "myPubSubSubscriptionNamePrefix"
  # value    = "_turbot"
}
