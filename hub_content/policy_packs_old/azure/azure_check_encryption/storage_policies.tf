# Encryption in Transit Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-in-transit

# Azure > Storage > Storage Account > Encryption in Transit
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/storageAccountEncryptionInTransit
resource "turbot_policy_setting" "azure_storage_storage_account_encryption_in_transit" {
  count    = var.azure_storage_storage_account_encryption_in_transit_policies ? 1 : 0
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountEncryptionInTransit"
  value    = "Check: Enabled"
}

# Azure > Storage > Storage Account > Approved > Usage
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/storageAccountApprovedUsage
resource "turbot_policy_setting" "azure_storage_storage_account_approved_usage" {
  count          = var.azure_storage_storage_account_approved_usage_policies ? 1 : 0
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
