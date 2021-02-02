## Azure Storage Queue
resource "turbot_policy_setting" "azure_storage_queue_service_logging" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLogging"
  value    = "Check: Per Logging > Properties"
}

resource "turbot_policy_setting" "azure_storage_queue_service_logging_properties" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLoggingProperties"
  value    = <<EOT
- Read
- Write
- Delete
EOT
}

resource "turbot_policy_setting" "azure_storage_queue_service_logging_properties_retention_days" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLoggingPropertiesRetentionDays"
  value    = 7
}