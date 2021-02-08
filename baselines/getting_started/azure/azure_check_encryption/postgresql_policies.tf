## PostgreSQL Server
resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverEncryptionInTransit"
  value    = "Check: Enabled"
}
