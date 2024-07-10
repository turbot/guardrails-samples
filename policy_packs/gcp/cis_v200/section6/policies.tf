# GCP > SQL > Instance > Database Flags
resource "turbot_policy_setting" "gcp_sql_instance_database_flags" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceDatabaseFlags"
  note     = "GCP CIS v2.0.0 - Control: 6.1.2, 6.1.3, 6.2.1, 6.2.2, 6.2.3, 6.2.4, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.3.1, 6.3.2, 6.3.3, 6.3.4, 6.3.5, 6.3.6 and 6.3.7"
  value    = "Check: Database flags are correct"
  # value    = "Enforce: Set Database flags"
}

# GCP > SQL > Instance > Database Flags > MySQL > Template
resource "turbot_policy_setting" "gcp_sql_instance_database_flags_mysql_template" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceMysqlDatabaseFlagsTemplate"
  note     = "GCP CIS v2.0.0 - Control: 6.1.2 and 6.1.3"
  value    = <<-EOT
    {
      "skip_show_database": "on",
      "local_infile": "off"
    }
  EOT
}

# GCP > SQL > Instance > Database Flags > PostgreSQL > Template
resource "turbot_policy_setting" "gcp_sql_instance_database_flags_postgresql_template" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instancePostgresqlDatabaseFlagsTemplate"
  note     = "GCP CIS v2.0.0 - Control: 6.2.1, 6.2.2, 6.2.3, 6.2.4, 6.2.5, 6.2.6, 6.2.7 and 6.2.8"
  value    = <<-EOT
    {
      "log_error_verbosity": "default",
      "log_connections": "on",
      "log_disconnections": "on",
      "log_statement": "ddl",
      "log_min_messages": "log",
      "log_min_error_statement": "panic",
      "log_min_duration_statement": -1,
      "cloudsql.enable_pgaudit": "on"
    }
  EOT
}

# GCP > SQL > Instance > Database Flags > SQL Server > Template
resource "turbot_policy_setting" "gcp_sql_instance_database_flags_sql_server_template" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceSqlDatabaseFlagsTemplate"
  note     = "GCP CIS v2.0.0 - Control: 6.3.1, 6.3.2, 6.3.3, 6.3.4, 6.3.5, 6.3.6 and 6.3.7"
  value    = <<-EOT
    {
      "3625": "on",
      "external scripts enabled": "off",
      "cross db ownership chaining": "off",
      "user connections": 10,
      "user options": 2,
      "remote access": "off",
      "contained database authentication": "off"
    }
  EOT
}

# GCP > SQL > Instance > Data Protection > Managed Backups
resource "turbot_policy_setting" "gcp_sql_instance_data_protection_managed_backups" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceDataProtectionManagedBackups"
  note     = "GCP CIS v2.0.0 - Control: 6.7"
  value    = "Skip"
  # value    = "Enforce: Manage snapshots, per Managed Backups > Schedule and Managed Backups > Minimum Schedule"
}

# GCP > SQL > Instance > Data Protection > Managed Backups > Schedule
resource "turbot_policy_setting" "gcp_sql_instance_data_protection_managed_backups_schedule" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceDataProtectionSchedule"
  note     = "GCP CIS v2.0.0 - Control: 6.7"
  value    = "Enforce: Daily for 30 days"
  # value    = "Enforce: Daily with backoff to 1 year"
  # value    = "Enforce: Hourly with backoff to 3 months"
  # value    = "Enforce: Hourly with backoff to 1 year"
}

# GCP > SQL > Instance > Data Protection > Managed Backups > Minimum Schedule
resource "turbot_policy_setting" "gcp_sql_instance_data_protection_managed_backups_minimum_schedule" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceDataProtectionMinimumSchedule"
  note     = "GCP CIS v2.0.0 - Control: 6.7"
  value    = "Enforce: Daily for 30 days"
  # value    = "Enforce: Daily with backoff to 1 year"
  # value    = "Enforce: Hourly with backoff to 3 months"
  # value    = "Enforce: Hourly with backoff to 1 year"
}
