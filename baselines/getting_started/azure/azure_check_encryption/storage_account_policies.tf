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