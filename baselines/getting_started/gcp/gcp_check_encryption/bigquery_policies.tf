###  Big Query Dataset Unencrypted 
# GCP > BigQuery > Dataset > Approved
# https://turbot.com/v5/mods/turbot/gcp-bigquery/inspect#/policy/types/datasetApproved
resource "turbot_policy_setting" "gcp_bigquery_dataset_approved" {
  count    = var.enable_bigquery_dataset_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

# GCP > BigQuery > Dataset > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-bigquery/inspect#/policy/types/datasetApprovedEncryptionAtRest
resource "turbot_policy_setting" "gcp_bigquery_dataset_approved_encryption_at_rest" {
  count    = var.enable_bigquery_dataset_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}

# GCP > BigQuery > Table > Approved
# https://turbot.com/v5/mods/turbot/gcp-bigquery/inspect#/policy/types/tableApproved
###  Big Query Table Unencrypted 
resource "turbot_policy_setting" "gcp_bigquery_table_approved" {
  count    = var.enable_bigquery_table_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

# GCP > BigQuery > Table > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-bigquery/inspect#/policy/types/tableApprovedEncryptionAtRest
resource "turbot_policy_setting" "gcp_bigquery_table_approved_encryption_at_rest" {
  count    = var.enable_bigquery_table_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}
