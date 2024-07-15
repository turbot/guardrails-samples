# Azure > SQL > Server > Auditing
resource "turbot_policy_setting" "azure_sql_server_auditing" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditing"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1 and 4.1.6"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > SQL > Server > Auditing > Storage Account
resource "turbot_policy_setting" "azure_sql_server_auditing_storage_account" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditingStorageAccount"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1 and 4.1.6"
  # Your storage account name
  value = "myStorageAccount"
}

# Azure > SQL > Server > Auditing > Retention Days
resource "turbot_policy_setting" "azure_sql_server_auditing_retention_days" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditingRetentionDays"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1 and 4.1.6"
  value    = "90"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Control: 4.1.2"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Network > Network Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApprovedRules"
  note     = "Azure CIS v2.0.0 - Control: 4.1.2"
  value    = <<EOT
    REJECT $.turbot.cidr:0.0.0.0/0

    APPROVE *
  EOT
}

# Azure > SQL > Database > Encryption At Rest
resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  note     = "Azure CIS v2.0.0 - Control: 4.1.5"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > SQL > Server > Active Directory Administrator
resource "turbot_policy_setting" "azure_sql_server_active_directory_administrator" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverActiveDirectoryAdministrator"
  note     = "Azure CIS v2.0.0 - Control: 4.1.4"
  value    = "Check: Enabled to Active Directory Administrator > Name"
  # value    = "Enforce: Enabled to Active Directory Administrator > Name"
}

# Azure > SQL > Server > Active Directory Administrator > Name
resource "turbot_policy_setting" "azure_sql_server_active_directory_administrator_name" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverActiveDirectoryAdministratorName"
  note     = "Azure CIS v2.0.0 - Control: 4.1.4"
  # Your admin user
  value = "myAdminUser"
}

# Azure > SQL > Server > Advanced Data Security
resource "turbot_policy_setting" "azure_sql_server_data_security" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverDataSecurity"
  note     = "Azure CIS v2.0.0 - Control: 4.2.1, 4.2.2, 4.2.3, 4.2.4 and 4.2.5"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# Azure > SQL > Server > Advanced Data Security > Threat Protection > Types
resource "turbot_policy_setting" "azure_sql_server_threat_protection_types" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionTypes"
  note     = "Azure CIS v2.0.0 - Control: 4.2.1"
  value    = <<-EOT
    - "SQL Injection"
    - "SQL Injection Vulnerability"
    - "Data Exfiltration"
    - "Unsafe Action"
    - "Access Anomaly"
    - "Brute Force"
  EOT
}

# Azure > SQL > Server > Advanced Data Security > Threat Protection > Notify Admins
resource "turbot_policy_setting" "azure_sql_server_threat_protection_notify_admins" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionNotifyAdmins"
  note     = "Azure CIS v2.0.0 - Control: 4.2.1"
  value    = "Enabled"
}

# Azure > SQL > Server > Advanced Data Security > Threat Protection > Email Addresses
resource "turbot_policy_setting" "azure_sql_server_threat_protection_email_addresses" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionEmailAddresses"
  note     = "Azure CIS v2.0.0 - Control: 4.2.1"
  value    = <<-EOT
    - "email@example.com"
  EOT
}

# Azure > SQL > Server > Advanced Data Security > Vulnerability Assessment > Storage Account
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_storage_account" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentStorageAccount"
  note     = "Azure CIS v2.0.0 - Control: 4.2.2"
  # Your storage account name
  value = "myStorageAccount"
}

# Azure > SQL > Server > Advanced Data Security > Vulnerability Assessment > Periodic Scans
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_periodic_scan" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentPeriodicScans"
  note     = "Azure CIS v2.0.0 - Control: 4.2.3"
  value    = "Enabled"
}

# Azure > SQL > Server > Advanced Data Security > Vulnerability Assessment > Periodic Scans > Email Addresses
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_email_addresses" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentEmailAddresses"
  note     = "Azure CIS v2.0.0 - Control: 4.2.4"
  value    = <<-EOT
    - "email@example.com"
  EOT
}

# Azure > SQL > Server > Advanced Data Security > Vulnerability Assessment > Periodic Scans > Notify Admins
resource "turbot_policy_setting" "azure_sql_server_vulnerability_assessment_notify_admins" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverVulnerabilityAssessmentNotifyAdmins"
  note     = "Azure CIS v2.0.0 - Control: 4.2.5"
  value    = "Enabled"
}
