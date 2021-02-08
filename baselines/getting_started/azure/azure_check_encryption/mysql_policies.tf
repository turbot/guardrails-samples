## MySQL Server
resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit" {
  resource = turbot_smart_folder.azure_encryption.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/serverEncryptionInTransit"
  value    = "Check: Enabled"
}
