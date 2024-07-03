# Azure > Storage > Storage Account > Encryption in Transit
resource "turbot_policy_setting" "azure_storage_account_encryption_in_transit" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 3.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > Storage > Storage Account > Access Keys > Rotation Reminder
resource "turbot_policy_setting" "azure_storage_account_access_keys_rotation_reminder" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessKeysRotationReminder"
  note     = "Azure CIS v2.0.0 - Control: 3.3"
  value    = "Check: Enabled per Rotation Reminder > Days"
  # value    = "Enforce: Enabled per Rotation Reminder > Days"
}

# Azure > Storage > Storage Account > Access Keys > Rotation Reminder > Days
resource "turbot_policy_setting" "azure_storage_account_access_keys_rotation_reminder_days" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessKeysRotationReminderDays"
  note     = "Azure CIS v2.0.0 - Control: 3.3"
  value    = 90
}

# Azure > Storage > Storage Account > Queue > Logging
resource "turbot_policy_setting" "azure_storage_account_queue_service_logging" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.5"
  value    = "Check: Per Logging > Properties"
  # value    = "Enforce: Per Logging > Properties"
}

# Azure > Storage > Storage Account > Queue > Logging > Properties
resource "turbot_policy_setting" "azure_storage_account_queue_service_logging_properties" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.5"
  value    = <<EOT
    [
      "Read",
      "Write",
      "Delete"
    ]
  EOT
}

# Azure > Storage > Storage Account > Firewall
resource "turbot_policy_setting" "azure_storage_account_queue_service_logging" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountFirewall"
  note     = "Azure CIS v2.0.0 - Control: 3.9"
  value    = "Check: Allow all networks"
  # value    = "Check: Allow only approved virtual networks and IP ranges"
  # value    = "Enforce: Allow all networks"
  # value    = "Enforce: Allow only approved virtual networks and IP ranges"
}

# Azure > Storage > Storage Account > Firewall > Exceptions
resource "turbot_policy_setting" "azure_storage_account_queue_service_logging" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountFirewallExceptions"
  note     = "Azure CIS v2.0.0 - Control: 3.9"
  value    = "Check: Allow only Exceptions > Items"
  # value    = "Enforce: Allow only Exceptions > Items"
}

# Azure > Storage > Storage Account > Firewall > Exceptions > Items
resource "turbot_policy_setting" "azure_storage_account_queue_service_logging" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountFirewallExceptionsItems"
  note     = "Azure CIS v2.0.0 - Control: 3.9"
  value    = ["Azure services"]
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete
resource "turbot_policy_setting" "azure_storage_account_data_protection_soft_delete" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDelete"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = "Check: Configured per Soft Delete > * policies"
  # value    = "Enforce: Configured per Soft Delete > * policies"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Blobs
resource "turbot_policy_setting" "azure_storage_account_soft_delete_blobs" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteBlobs"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = "Enabled"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Blobs > Retention Days
resource "turbot_policy_setting" "azure_storage_account_soft_delete_blobs_retention_days" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteBlobsRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = 7
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Containers
resource "turbot_policy_setting" "azure_storage_account_soft_delete_containers" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteContainers"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = "Enabled"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Containers > Retention Days
resource "turbot_policy_setting" "azure_storage_account_soft_delete_containers_retention_days" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteContainersRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = 7
}

# Azure > Storage > Storage Account > Blob > Logging
resource "turbot_policy_setting" "azure_storage_account_blob_service_logging" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountBlobServiceLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.13"
  value    = "Check: Per Logging > Properties"
  # value    = "Enforce: Per Logging > Properties"
}

# Azure > Storage > Storage Account > Blob > Logging > Properties
resource "turbot_policy_setting" "azure_storage_account_blob_service_logging_properties" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountBlobServiceLoggingProperties"
  note     = "Azure CIS v2.0.0 - Control: 3.13"
  value    = <<EOT
    [
      "Read",
      "Write",
      "Delete"
    ]
  EOT
}

# Azure > Storage > Storage Account > Minimum TLS Version
resource "turbot_policy_setting" "azure_storage_account_minimum_tls_version" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 3.15"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
