# Azure > Storage > Storage Account > Encryption in Transit
resource "turbot_policy_setting" "azure_storage_storage_account_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 3.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > Storage > Storage Account >  Approved
resource "turbot_policy_setting" "azure_storage_storage_account_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountApproved"
  note     = "Azure CIS v2.0.0 - Control: 3.2"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Storage > Storage Account >  Approved > Infrastructure Encryption
resource "turbot_policy_setting" "azure_storage_storage_account_approved_infrastructure_encryption" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountApprovedInfrastructureEncryption"
  note     = "Azure CIS v2.0.0 - Control: 3.2"
  value    = "Approved if enabled"
}

# Azure > Storage > Storage Account > Access Keys > Rotation Reminder
resource "turbot_policy_setting" "azure_storage_storage_account_access_keys_rotation_reminder" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessKeysRotationReminder"
  note     = "Azure CIS v2.0.0 - Control: 3.3"
  value    = "Check: Enabled per Rotation Reminder > Days"
  # value    = "Enforce: Enabled per Rotation Reminder > Days"
}

# Azure > Storage > Storage Account > Access Keys > Rotation Reminder > Days
resource "turbot_policy_setting" "azure_storage_storage_account_access_keys_rotation_reminder_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountAccessKeysRotationReminderDays"
  note     = "Azure CIS v2.0.0 - Control: 3.3"
  value    = 90
}

# Azure > Storage > Storage Account > Queue > Logging
resource "turbot_policy_setting" "azure_storage_storage_account_queue_service_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.5"
  value    = "Check: Per Logging > Properties"
  # value    = "Enforce: Per Logging > Properties"
}

# Azure > Storage > Storage Account > Queue > Logging > Properties
resource "turbot_policy_setting" "azure_storage_storage_account_queue_service_logging_properties" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLoggingProperties"
  note     = "Azure CIS v2.0.0 - Control: 3.5"
  value    = <<-EOT
    - "Read"
    - "Write"
    - "Delete"
  EOT
}

# Azure > Storage > Storage Account > Queue > Logging > Properties > Retention Days
resource "turbot_policy_setting" "azure_storage_storage_account_queue_service_logging_properties_retention_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/queueServiceLoggingPropertiesRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 3.5"
  # Number of days for which metrics or logging or soft-deleted data should be retained. Should not be greater than 365.
  value = 7
}

# Azure > Storage > Storage Account > Blob Public Access
resource "turbot_policy_setting" "azure_storage_storage_account_blob_public_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountPublicAccess"
  note     = "Azure CIS v2.0.0 - Control: 3.7"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete
resource "turbot_policy_setting" "azure_storage_storage_account_data_protection_soft_delete" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDelete"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = "Check: Configured per Soft Delete > * policies"
  # value    = "Enforce: Configured per Soft Delete > * policies"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Blobs
resource "turbot_policy_setting" "azure_storage_storage_account_soft_delete_blobs" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteBlobs"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = "Enabled"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Blobs > Retention Days
resource "turbot_policy_setting" "azure_storage_storage_account_soft_delete_blobs_retention_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteBlobsRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  # Number of days for which blob data should be retained. Should not be greater than 365.
  value = 7
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Containers
resource "turbot_policy_setting" "azure_storage_storage_account_soft_delete_containers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteContainers"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  value    = "Enabled"
}

# Azure > Storage > Storage Account > Data Protection > Soft Delete > Containers > Retention Days
resource "turbot_policy_setting" "azure_storage_storage_account_soft_delete_containers_retention_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountDataProtectionSoftDeleteContainersRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 3.11"
  # Number of days for which container data should be retained. Should not be greater than 365.
  value = 7
}

# Azure > Storage > Storage Account > Blob > Logging
resource "turbot_policy_setting" "azure_storage_storage_account_blob_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountBlobLogging"
  note     = "Azure CIS v2.0.0 - Control: 3.13"
  value    = "Check: Per `Logging > *`"
  # value    = "Enforce: Per `Logging > *`"
}

# Azure > Storage > Storage Account > Blob > Logging > Properties
resource "turbot_policy_setting" "azure_storage_storage_account_blob_logging_properties" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountBlobLoggingProperties"
  note     = "Azure CIS v2.0.0 - Control: 3.13"
  value    = <<-EOT
    - "Read"
    - "Write"
    - "Delete"
  EOT
}

# Azure > Storage > Storage Account > Blob > Logging > Retention Days
resource "turbot_policy_setting" "azure_storage_storage_account_blob_logging_retention_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountBlobLoggingRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 3.13"
  # Number of days for which metrics or logging or soft-deleted data should be retained. Should not be greater than 365.
  value = 7
}

# Azure > Storage > Storage Account > Minimum TLS Version
resource "turbot_policy_setting" "azure_storage_storage_account_minimum_tls_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 3.15"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
