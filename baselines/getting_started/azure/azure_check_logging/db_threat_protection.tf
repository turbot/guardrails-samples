## Azure > SQL > Server > Advanced Data Security > Threat Protection > Types
resource "turbot_policy_setting" "azure_sql_server_threat_protection_types" {
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
resource "turbot_policy_setting" "azure_sql_database_threat_protection_types" {
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

