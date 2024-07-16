resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest for Azure SQL Databases"
  description = "Ensure hat all stored data is encrypted, protecting it from unauthorized access and potential breaches."
  akas        = ["azure_sql_enforce_encryption_at_rest_for_databases"]
}
