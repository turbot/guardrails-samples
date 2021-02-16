## Azure SQL Server
# Azure > SQL > Server > Auditing
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/serverAuditing
resource "turbot_policy_setting" "azure_sql_server_auditing" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditing"
  value    = "Check: Enabled"
}

# Azure > SQL > Server > Advanced Data Security
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/serverDataSecurity
resource "turbot_policy_setting" "azure_sql_server_data_security" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverDataSecurity"
  value    = "Check: Enabled"
}


## Azure SQL Database
# Azure > SQL > Database > Auditing
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/databaseAuditing
resource "turbot_policy_setting" "azure_sql_database_auditing" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseAuditing"
  value    = "Check: Enabled"
}

# Azure > SQL > Database > Advanced Data Security
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/databaseDataSecurity
resource "turbot_policy_setting" "azure_sql_database_data_security" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseDataSecurity"
  value    = "Check: Enabled"
}


## Azure PostgrSQL
# Azure > PostgreSQL > Server > Audit Logging
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLogging
resource "turbot_policy_setting" "azure_postgresql_server_auditing" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLogging"
  value    = "Check: Audit Logging > *"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Checkpoints
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogCheckpoints
resource "turbot_policy_setting" "azure_postgresql_server_auditing_checkpoints" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogCheckpoints"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Connections
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogConnections
resource "turbot_policy_setting" "azure_postgresql_server_auditing_connections" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogConnections"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Disconnections
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogDisconnections
resource "turbot_policy_setting" "azure_postgresql_server_auditing_disconnections" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDisconnections"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Duration
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogDuration
resource "turbot_policy_setting" "azure_postgresql_server_auditing_duration" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDuration"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Retention Days
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogRetentionDays
resource "turbot_policy_setting" "azure_postgresql_server_auditing_duration_days" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogRetentionDays"
  value    = ">= 1 Day"
}