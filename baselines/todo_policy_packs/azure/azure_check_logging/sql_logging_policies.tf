# Azure > SQL > Server > Auditing
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/serverAuditing
resource "turbot_policy_setting" "azure_sql_server_auditing" {
  count    = var.azure_sql_server_auditing_policies ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditing"
  value    = "Check: Enabled"
}

# Azure > SQL > Server > Advanced Data Security
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/serverDataSecurity
resource "turbot_policy_setting" "azure_sql_server_data_security" {
  count    = var.azure_sql_server_data_security_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverDataSecurity"
  value    = "Check: Enabled"
}

# Azure > SQL > Database > Auditing
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/databaseAuditing
resource "turbot_policy_setting" "azure_sql_database_auditing" {
  count    = var.azure_sql_database_auditing_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseAuditing"
  value    = "Check: Enabled"
}

# Azure > SQL > Database > Advanced Data Security
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/databaseDataSecurity
resource "turbot_policy_setting" "azure_sql_database_data_security" {
  count    = var.azure_sql_database_data_security_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseDataSecurity"
  value    = "Check: Enabled"
}
