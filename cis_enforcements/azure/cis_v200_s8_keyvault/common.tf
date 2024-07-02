# Smart Folder
resource "turbot_smart_folder" "azure_cis_v200_s8_keyvault" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 8 - Key Vault"
  description = "This section covers security recommendations to follow for the configuration and use of Azure Key Vault."
}

# Azure > KeyVault > Enabled
resource "turbot_policy_setting" "azure_keyvault_enabled" {
  resource = turbot_smart_folder.azure_cis_v200_s8_keyvault.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/keyVaultEnabled"
  value    = "Enabled"
}
