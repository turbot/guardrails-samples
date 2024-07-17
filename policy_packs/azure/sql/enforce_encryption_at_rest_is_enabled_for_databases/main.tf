resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest is Enabled for Azure SQL Databases"
  description = "Ensure that data is encrypted when stored, organizations can enhance data security, comply with regulatory requirements, and mitigate the risks associated with data theft or loss."
  akas        = ["azure_sql_enforce_encryption_at_rest_is_enabled_for_databases"]
}
