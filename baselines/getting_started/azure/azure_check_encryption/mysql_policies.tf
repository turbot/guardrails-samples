# Encryption in Transit Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-in-transit

# Azure > MySQL > Server > Encryption in Transit
# https://turbot.com/v5/mods/turbot/azure-mysql/inspect#/policy/types/serverEncryptionInTransit
resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/serverEncryptionInTransit"
  value    = "Check: Enabled"
}
