###  Big Query Dataset Unencrypted 
resource "turbot_policy_setting" "gcp_bigquery_dataset_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_bigquery_dataset_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}

###  Big Query Table Unencrypted 
resource "turbot_policy_setting" "gcp_bigquery_table_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_bigquery_table_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}
