## Azure > SQL > Server > Advanced Data Security > Threat Protection > Types
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/serverThreatProtection
resource "turbot_policy_setting" "azure_sql_server_threat_protection_types" {
  count    = var.azure_sql_server_threat_protection_types_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverThreatProtectionTypes"
  value    = <<EOT
- SQL Injection
- SQL Injection Vulnerability
- Data Exfiltration
- Unsafe Action
- Access Anomaly
- Brute Force
EOT
}

## Azure > SQL > Database > Advanced Data Security > Threat Protection > Types
# https://turbot.com/v5/mods/turbot/azure-sql/inspect#/policy/types/databaseThreatProtection
resource "turbot_policy_setting" "azure_sql_database_threat_protection_types" {
  count    = var.azure_sql_database_threat_protection_types_polices ? 1 : 0
  resource = turbot_smart_folder.azure_logging.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseThreatProtectionTypes"
  value    = <<EOT
- SQL Injection
- SQL Injection Vulnerability
- Data Exfiltration
- Unsafe Action
- Access Anomaly
- Brute Force
EOT
}

