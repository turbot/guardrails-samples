resource "turbot_smart_folder" "gcp_folder" {
  title         = var.smart_folder_title
  description   = "Smart folder for importing a gcp project"
  parent        = var.folder_parent
}

# Sets the policy Enable for API Enabled in Pub/Sub
# GCP > Pub/Sub > API Enabled
resource "turbot_policy_setting" "pubsubApiEnabled" {
  resource    = turbot_smart_folder.gcp_folder.id
  type        = "tmod:@turbot/gcp-pubsub#/policy/types/pubsubApiEnabled"
  value       = "Enforce: Enabled"
}

# Sets the policy Enable for API Enabled in Logging
# GCP > Logging > API Enabled
resource "turbot_policy_setting" "loggingApiEnabled" {
  resource    = turbot_smart_folder.gcp_folder.id
  type        = "tmod:@turbot/gcp-logging#/policy/types/loggingApiEnabled"
  value       = "Enforce: Enabled"
}

# Sets the policy for Logging
# GCP > Turbot > Event Handlers > Logging
resource "turbot_policy_setting" "eventHandlersLogging" {
  resource    = turbot_smart_folder.gcp_folder.id
  type        = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  value       = "Enforce: Configured"
}

# Sets the policy for Pub/Sub
# GCP > Turbot > Event Handlers > Pub/Sub
resource "turbot_policy_setting" "eventHandlersPubSub" {
  resource    = turbot_smart_folder.gcp_folder.id
  type        = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  value       = "Enforce: Configured"
}