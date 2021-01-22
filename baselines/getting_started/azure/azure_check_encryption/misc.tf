# Ensure encryption on various Azure services

## Disk only wth Customer Managed Key - EncryptionAtRestWithCustomerKey not #EncryptionAtRestWithPlatformKey
resource "turbot_policy_setting" "azure_compute_disk_approved_usage" {
  resource       = turbot_smart_folder.azure_encryption.id
  type           = "tmod:@turbot/azure-compute#/policy/types/diskApprovedUsage"
  template_input = <<EOT
{
  disk{
    encryption: get(path:"encryption.type")
  }
}
EOT
  template       = <<EOT
{%- if $.disk.encryption == "EncryptionAtRestWithPlatformKey" -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

## Storage Account
resource "turbot_policy_setting" "azure_storage_storage_account_encryption_in_transit" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountEncryptionInTransit"
  value    = "Check: Enabled"
}

resource "turbot_policy_setting" "azure_storage_storage_account_approved_usage" {
  resource       = turbot_smart_folder.azure_encryption.id
  type           = "tmod:@turbot/azure-storage#/policy/types/storageAccountApprovedUsage"
  template_input = <<EOT
{
  storageAccount{
    encryption{
      services
    }
  }
}
EOT
  template       = <<EOT
{% set regExp = r/false/i %}
{%- if regExp.test($.storageAccount.encryption.services.blob.enabled) 
or regExp.test($.storageAccount.encryption.services.file.enabled) -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

## SQL Database
resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  value    = "Check: Enabled"
}

## PostgreSQL Server
resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverEncryptionInTransit"
  value    = "Check: Enabled"
}

## MySQL Server
resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/serverEncryptionInTransit"
  value    = "Check: Enabled"
}

## App Services Function App
resource "turbot_policy_setting" "azure_appservice_function_app_approved_usage" {
  resource       = turbot_smart_folder.azure_encryption.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/functionAppApprovedUsage"
  template_input = <<EOT
{
  functionApp{
    httpsOnly
  }
}
EOT
  template       = <<EOT
{%- if $.functionApp.httpsOnly == false -%}
Not approved
{%- else -%}
Approved
{%- endif -%}
EOT
}

## App Services Web App
resource "turbot_policy_setting" "azure_appservice_web_app_approved_usage" {
  resource       = turbot_smart_folder.azure_encryption.id
  type           = "tmod:@turbot/azure-appservice#/policy/types/webAppApprovedUsage"
  template_input = <<EOT
{
  webApp{
    httpsOnly
  }
}
EOT
  template       = <<EOT
{%- if $.webApp.httpsOnly == false -%}
Not approved
{%- else -%}
Approved
{%- endif -%}
EOT
}