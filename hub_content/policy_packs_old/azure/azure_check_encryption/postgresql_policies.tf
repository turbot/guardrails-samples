# Encryption in Transit Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-in-transit

# Azure > PostgreSQL > Server > Encryption in Transit
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverEncryptionInTransit
resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit" {
  count    = var.azure_postgresql_server_encryption_in_transit_policies ? 1 : 0
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverEncryptionInTransit"
  value    = "Check: Enabled"
}
