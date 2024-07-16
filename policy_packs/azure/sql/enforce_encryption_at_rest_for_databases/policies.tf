# Azure > SQL > Database > Encryption at Rest
resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
