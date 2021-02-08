## SQL Database
resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  value    = "Check: Enabled"
}