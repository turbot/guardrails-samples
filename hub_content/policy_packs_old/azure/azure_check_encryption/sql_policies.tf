# Encryption at Rest Guardrails - https://turbot.com/v5/docs/concepts/guardrails/encryption-at-rest

# Azure > SQL > Database > Encryption at Rest
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/databaseEncryptionAtRest
resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  count    = var.azure_sql_database_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  value    = "Check: Enabled"
}
