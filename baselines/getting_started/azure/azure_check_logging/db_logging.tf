## Azure SQL Server
resource "turbot_policy_setting" "azure_sql_server_auditing" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditing"
  value    = "Check: Enabled"
}

resource "turbot_policy_setting" "azure_sql_server_data_security" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverDataSecurity"
  value    = "Check: Enabled"
}


## Azure SQL Database
resource "turbot_policy_setting" "azure_sql_database_auditing" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseAuditing"
  value    = "Check: Enabled"
}

resource "turbot_policy_setting" "azure_sql_database_data_security" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseDataSecurity"
  value    = "Check: Enabled"
}


## Azure PostgrSQL
resource "turbot_policy_setting" "azure_postgresql_server_auditing" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLogging"
  value    = "Check: Audit Logging > *"
}

resource "turbot_policy_setting" "azure_postgresql_server_auditing_checkpoints" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogCheckpoints"
  value    = "On"
}

resource "turbot_policy_setting" "azure_postgresql_server_auditing_connections" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogConnections"
  value    = "On"
}

resource "turbot_policy_setting" "azure_postgresql_server_auditing_disconnections" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDisconnections"
  value    = "On"
}

resource "turbot_policy_setting" "azure_postgresql_server_auditing_duration" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDuration"
  value    = "On"
}

resource "turbot_policy_setting" "azure_postgresql_server_auditing_duration_days" {
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogRetentionDays"
  value    = ">= 1 Day"
}