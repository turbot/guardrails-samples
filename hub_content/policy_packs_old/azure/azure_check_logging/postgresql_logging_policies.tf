# Azure > PostgreSQL > Server > Audit Logging
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLogging
resource "turbot_policy_setting" "azure_postgresql_server_auditing" {
  count    = var.azure_postgresql_server_auditing_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLogging"
  value    = "Check: Audit Logging > *"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Checkpoints
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogCheckpoints
resource "turbot_policy_setting" "azure_postgresql_server_auditing_checkpoints" {
  count    = var.azure_postgresql_server_auditing_checkpoints_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogCheckpoints"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Connections
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogConnections
resource "turbot_policy_setting" "azure_postgresql_server_auditing_connections" {
  count    = var.azure_postgresql_server_auditing_connections_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogConnections"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Disconnections
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogDisconnections
resource "turbot_policy_setting" "azure_postgresql_server_auditing_disconnections" {
  count    = var.azure_postgresql_server_auditing_disconnections_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDisconnections"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Duration
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogDuration
resource "turbot_policy_setting" "azure_postgresql_server_auditing_duration" {
  count    = var.azure_postgresql_server_auditing_duration_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDuration"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Retention Days
# https://turbot.com/v5/mods/turbot/azure-postgresql/inspect#/policy/types/serverAuditLoggingLogRetentionDays
resource "turbot_policy_setting" "azure_postgresql_server_auditing_duration_days" {
  count    = var.azure_postgresql_server_auditing_duration_days_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogRetentionDays"
  value    = ">= 1 Day"
}
