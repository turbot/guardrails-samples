# Ensure encryption on various Azure services

## Disk only wth Customer Managed Key - EncryptionAtRestWithCustomerKey not #EncryptionAtRestWithPlatformKey
# Azure > Compute > Disk > Approved > Usage
# https://turbot.com/v5/mods/turbot/azure-compute/inspect#/policy/types/diskApprovedUsage
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
