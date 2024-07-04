# Azure > SQL > Server > Auditing
resource "turbot_policy_setting" "azure_sql_server_auditing" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditing"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > SQL > Server > Auditing -> Storage Account
resource "turbot_policy_setting" "azure_sql_server_auditing_storage_account" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditingStorageAccount"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1"
  value    = "teststorageaccmr"
  # value    = "https://teststorageaccmr.blob.core.windows.net/"
}

# Azure > NSG > IngressRule > Approved
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Control: 4.1.2"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > NSG > IngressRule > Approved > Rules
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  note     = "Azure CIS v2.0.0 - Control: 4.1.2. For complete enforcement, the rules for 4.1.2 should be merged with the rules for 6.1.4."
  value    = <<EOT
    REJECT $.turbot.cidr:0.0.0.0/0 $.turbot.ports=1433  #CISv2.0 4.1.2
    APPROVE *
  EOT
}

# Azure > SQL > Server > Auditing -> Retention Days
resource "turbot_policy_setting" "azure_sql_server_auditing_retention_days" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditingRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1 and 4.1.6"
  value    = "100"
  # value    = "maximum - 3285"
}

# Azure > SQL > Database > Encryption At Rest
resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  note     = "Azure CIS v2.0.0 - Control: 4.1.5"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > SQL > Server > Active Directory Administrator
resource "turbot_policy_setting" "azure_sql_server_active_directory_administrator" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverActiveDirectoryAdministrator"
  note     = "Azure CIS v2.0.0 - Control: 4.1.4"
  value    = "Check: Enabled to Active Directory Administrator > Name"
  # value    = "Enforce: Enabled to Active Directory Administrator > Name"
}

# Azure > SQL > Server > Active Directory Administrator > Name
resource "turbot_policy_setting" "azure_sql_server_active_directory_administrator_name" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverActiveDirectoryAdministratorName"
  note     = "Azure CIS v2.0.0 - Control: 4.1.4"
  value    = "testAdminUser"
}

# Azure > SQL > Server > DataSecurity
resource "turbot_policy_setting" "azure_sql_server_data_security" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverDataSecurity"
  note     = "Azure CIS v2.0.0 - Control: 4.2.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > SQL > Server > VulnerabilityAssessmentStorageAccount
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_storage_account" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentStorageAccount"
  note     = "Azure CIS v2.0.0 - Control: 4.2.2"
  value    = "teststorageaccmr"
  # value    = "teststorageaccmr/containername"
}

# Azure > SQL > Server > VulnerabilityAssessmentPeriodicScans
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_periodic_scan" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentPeriodicScans"
  note     = "Azure CIS v2.0.0 - Control: 4.2.3"
  value    = "Enabled"
}

# Azure > SQL > Server > VulnerabilityAssessmentEmailAddresses
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_email_addresses" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentEmailAddresses"
  note     = "Azure CIS v2.0.0 - Control: 4.2.4"
  value    = jsonencode(["test@turbot.com"])
}

# Azure > SQL > Server > ThreatProtectionNotifyAdmins
resource "turbot_policy_setting" "azure_sql_server_threat_protection_notify_admins" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionNotifyAdmins"
  note     = "Azure CIS v2.0.0 - Control: 4.2.5"
  value    = "Enabled"
}

# Azure > SQL > Server > ThreatProtectionEmailAddresses
resource "turbot_policy_setting" "azure_sql_server_threat_protection_email_addresses" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionEmailAddresses"
  note     = "Azure CIS v2.0.0 - Control: 4.2.5"
  value    = jsonencode(["test@turbot.com"])
}

# Azure > SQL > Server > ThreatProtectionTypes
resource "turbot_policy_setting" "azure_sql_server_threat_protection_types" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionTypes"
  note     = "Azure CIS v2.0.0 - Control: 4.2.5"
  value    = <<EOT
- SQL Injection
- SQL Injection Vulnerability
- Data Exfiltration
- Unsafe Action
- Access Anomaly
- Brute Force
EOT
}

# Azure > PostgreSQL > Server > EncryptionInTransit
resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.3.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > PostgreSQL > Server > EncryptionInTransitFlexi
resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit_flexi" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.3.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > PostgreSQL > Server > AuditLogging
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLogging"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "Check: Audit Logging > *"
  # value    = "Enforce: Audit Logging > *"
}

# Azure > PostgreSQL > Server > AuditLoggingFlexi
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_flexi" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerAuditLogging"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "Check: Audit Logging > *"
  # value    = "Enforce: Audit Logging > *"
}

# Azure > PostgreSQL > Server > AuditLogging > LogCheckpoints
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_checkpoints" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogCheckpoints"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "On"
}

# Azure > PostgreSQL > Server > AuditLogging > LogCheckpointsFlexi
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_checkpoints_flexi" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerAuditLoggingLogCheckpoints"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  value    = "On"
}

# Azure > PostgreSQL > Server > AuditLogging > LogConnections
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_connections" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogConnections"
  note     = "Azure CIS v2.0.0 - Control: 4.3.3"
  value    = "On"
}

# Azure > PostgreSQL > Server > AuditLogging > LogDisconnections
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_disconnections" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogDisconnections"
  note     = "Azure CIS v2.0.0 - Control: 4.3.4"
  value    = "On"
}

# Azure > PostgreSQL > Server > AuditLogging > ConnectionThrottling
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_connection_throttling" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingConnectionThrottling"
  note     = "Azure CIS v2.0.0 - Control: 4.3.5"
  value    = "On"
}

# Azure > PostgreSQL > Server > AuditLogging > LogRetentionDays
resource "turbot_policy_setting" "azure_postgresql_server_audit_logging_log_retention_days" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLoggingLogRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 4.3.6"
  value    = ">= 4 Days"
}

# Azure > PostgreSQL > Server > Approved
resource "turbot_policy_setting" "azure_postgresql_server_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverApproved"
  note     = "Azure CIS v2.0.0 - Control: 4.3.7 and 4.3.8"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > PostgreSQL > Server > ApprovedUsage
resource "turbot_policy_setting" "azure_postgresql_server_approved_usage" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverApprovedUsage"
  note     = "Azure CIS v2.0.0 - Control: 4.3.7 and 4.3.8"
  value    = "Approved"
}

# Azure > PostgreSQL > Server > Approved > Custom
resource "turbot_policy_setting" "azure_postgresql_server_approved_custom" {
  resource       = turbot_smart_folder.main.id
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
    {% set results = [] -%}

    {% if $.resource.infra_encryption and $.resource.infra_encryption == "Disabled" %}

      {%- set data = {
          "title": "Infrastructure Encryption",
          "result": "Not approved",
          "message": "Infrastructure encryption is disabled"
      } -%}

    {% else %}

      {%- set data = {
          "title": "Infrastructure Encryption",
          "result": "Approved",
          "message": "Infrastructure encryption is enabled"
      } -%}

    {% endif %}

    {% set results = results.concat(data) -%}

    {% if $.resource.firewallRulesName == "AllowAllWindowsAzureIps" %}

      {%- set data = {
          "title": "Allow access to Azure services",
          "result": "Not approved",
          "message": "Allow access to Azure services is enabled"
      } -%}

    {% elif $.resource.startIpAddress == "0.0.0.0" and $.resource.endIpAddress == "0.0.0.0" %}

      {%- set data = {
          "title": "Allow access to Azure services",
          "result": "Not approved",
          "message": "Allow access to Azure services is enabled"
      } -%}

    {% else %}

      {%- set data = {
          "title": "Allow access to Azure services",
          "result": "Approved",
          "message": "Allow access to Azure services is disabled"
      } -%}

    {% endif %}

    {% set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}

# Azure > MySQL > Server > EncryptionInTransit
resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/serverEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.4.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > MySQL > Server > EncryptionInTransitFlexi
resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit_flexi" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/flexibleServerEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.4.1"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > MySQL > Server > EncryptionInTransit
resource "turbot_policy_setting" "azure_mysql_flexible_server_minimum_tls_version_flexi" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/flexibleServerMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 4.4.2"
  value    = "Check: TLS 1.2"
  # value    = "Enforce: TLS 1.2"
}
