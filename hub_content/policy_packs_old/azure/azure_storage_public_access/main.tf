# Smart Folder Definition
resource "turbot_smart_folder" "azure_storage_public_access" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.
 
# Azure > Storage > Storage Account > Public Access
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/storageAccountPublicAccess
resource "turbot_policy_setting" "azure_storage_public_access_disabled" {
  resource = turbot_smart_folder.azure_storage_public_access.id
  type     = "tmod:@turbot/azure-storage#/policy/types/storageAccountPublicAccess"
  value    = "Check: Disabled"
  # "Skip"
  # "Check: Enabled"
  # "Check: Disabled"
  # "Enforce: Enabled"
  # "Enforce: Disabled"
}

# Azure > Storage > Container > Public Access Level
# https://turbot.com/v5/mods/turbot/azure-storage/inspect#/policy/types/containerPublicAccessLevel
resource "turbot_policy_setting" "azure_storage_public_access_level_private" {
  resource = turbot_smart_folder.azure_storage_public_access.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerPublicAccessLevel"
  value    = "Check: Private (No anonymous access)"
  # "Skip",
  # "Check: Blob (Anonymous read access for blobs only)",
  # "Check: Container (Anonymous read access for containers and blobs)",
  # "Check: Private (No anonymous access)",
  # "Enforce: Blob (Anonymous read access for blobs only)",
  # "Enforce: Container (Anonymous read access for containers and blobs)",
  # "Enforce: Private (No anonymous access)"
}