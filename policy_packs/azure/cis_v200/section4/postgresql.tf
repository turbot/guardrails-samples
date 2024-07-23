# Azure > PostgreSQL > Server > Encryption in Transit
resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.3.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > PostgreSQL > Flexible Server > Encryption in Transit
resource "turbot_policy_setting" "azure_postgresql_flexible_server_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.3.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > PostgreSQL > Server > Audit Logging
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLogging"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2, 4.3.3, 4.3.4, 4.3.5, 4.3.6, 4.3.7 and 4.3.8"
  value    = "Check: Audit Logging > *"
  # value    = "Enforce: Audit Logging > *"
}

# Azure > PostgreSQL > Flexible Server > Audit Logging
resource "turbot_policy_setting" "azure_postgresql_flexible_server_audit_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerAuditLogging"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "Check: Audit Logging > *"
  # value    = "Enforce: Audit Logging > *"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Checkpoints
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_checkpoints" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogCheckpoints"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "On"
}

# Azure > PostgreSQL > Flexible Server > Audit Logging > Log Checkpoints
resource "turbot_policy_setting" "azure_postgresql_flexible_server_audit_logging_log_checkpoints" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerAuditLoggingLogCheckpoints"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Connections
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_connections" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogConnections"
  note     = "Azure CIS v2.0.0 - Control: 4.3.3"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Disconnections
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_disconnections" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDisconnections"
  note     = "Azure CIS v2.0.0 - Control: 4.3.4"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Connection Throttling
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_connection_throttling" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingConnectionThrottling"
  note     = "Azure CIS v2.0.0 - Control: 4.3.5"
  value    = "On"
}

# Azure > PostgreSQL > Server > Audit Logging > Log Retention Days
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_retention_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 4.3.6"
  value    = ">= 4 Days"
}

# Azure > PostgreSQL > Server > Approved
resource "turbot_policy_setting" "azure_postgresql_server_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverApproved"
  note     = "Azure CIS v2.0.0 - Control: 4.3.7 and 4.3.8"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > PostgreSQL > Server > Approved > Custom
resource "turbot_policy_setting" "azure_postgresql_server_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-postgresql#/policy/types/serverApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 4.3.7 and 4.3.8"
  template_input = <<-EOT
    {
      resource {
        infrastructureEncryption: get(path:"infrastructureEncryption"),
        firewallRulesName: get(path:"firewallRules.name"),
        startIpAddress: get(path:"firewallRules.startIpAddress"),
        endIpAddress: get(path:"firewallRules.endIpAddress"),
      }
    }
  EOT
  template       = <<-EOT
    {%- set results = [] -%}

    {%- if $.resource.infra_encryption and $.resource.infra_encryption == "Disabled" -%}

      {%- set data = {
          "title": "Infrastructure Encryption",
          "result": "Not approved",
          "message": "Infrastructure encryption is disabled"
      } -%}

    {%- elif $.resource.infra_encryption and $.resource.infra_encryption == "Enabled" -%}

      {%- set data = {
          "title": "Infrastructure Encryption",
          "result": "Approved",
          "message": "Infrastructure encryption is enabled"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Infrastructure Encryption",
          "result": "Skip",
          "message": "No data for infrastructure encryption yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {%- if $.resource.firewallRulesName == "AllowAllWindowsAzureIps" -%}

      {%- set data = {
          "title": "Allow access to Azure services",
          "result": "Not approved",
          "message": "Allow access to Azure services is enabled"
      } -%}

    {%- elif $.resource.startIpAddress == "0.0.0.0" and $.resource.endIpAddress == "0.0.0.0" -%}

      {%- set data = {
          "title": "Allow access to Azure services",
          "result": "Not approved",
          "message": "Allow access to Azure services is enabled"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Allow access to Azure services",
          "result": "Approved",
          "message": "Allow access to Azure services is disabled"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}
