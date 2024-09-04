# Azure > MySQL > Server > Encryption in Transit
resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/serverEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.4.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > MySQL > Flexible Server > Encryption in Transit
resource "turbot_policy_setting" "azure_mysql_flexible_server_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/flexibleServerEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.4.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > MySQL > Flexible Server > Minimum TLS Version
resource "turbot_policy_setting" "azure_mysql_flexible_server_minimum_tls_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/flexibleServerMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 4.4.2"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
