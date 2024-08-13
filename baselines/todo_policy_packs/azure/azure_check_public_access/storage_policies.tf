# Azure > Storage > Storage Account > Public Access
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/storageAccountPublicAccess
resource "turbot_policy_setting" "azure_storage_account_public_access" {
  count    = var.enable_storage_account_public_access_policies ? 1 : 0
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountPublicAccess"
  value    = "Check: Enabled"
}

# Azure > Storage > Container > Public Access Level
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/containerPublicAccessLevel
resource "turbot_policy_setting" "azure_storage_container_public_access" {
  count    = var.enable_azure_storage_container_public_access_policies ? 1 : 0
  resource = turbot_smart_folder.azure_public_access.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerPublicAccessLevel"
  value    = "Check: Private (No anonymous access)"
              # "Check: Blob (Anonymous read access for blobs only)"
              # "Check: Container (Anonymous read access for containers and blobs)"
              # "Check: Private (No anonymous access)"
}
