# Azure > Storage > Storage Account > Queue > Logging
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/queueServiceLogging
resource "turbot_policy_setting" "azure_storage_queue_service_logging" {
  count    = var.azure_storage_queue_service_logging_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLogging"
  value    = "Check: Per Logging > Properties"
}

# Azure > Storage > Storage Account > Queue > Logging > Properties
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/queueServiceLoggingProperties
resource "turbot_policy_setting" "azure_storage_queue_service_logging_properties" {
  count    = var.azure_storage_queue_service_logging_properties_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLoggingProperties"
  value    = <<EOT
- Read
- Write
- Delete
EOT
}

# Azure > Storage > Storage Account > Queue > Logging > Properties > Retention Days
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/queueServiceLoggingPropertiesRetentionDays
resource "turbot_policy_setting" "azure_storage_queue_service_logging_properties_retention_days" {
  count    = var.azure_storage_queue_service_logging_properties_retention_days_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLoggingPropertiesRetentionDays"
  value    = 7
}
