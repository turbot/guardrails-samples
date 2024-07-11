# GCP > BigQuery > Dataset > Publicly Accessible
resource "turbot_policy_setting" "gcp_bigquery_dataset_publicly_accessible" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetPubliclyAccessible"
  note     = "GCP CIS v2.0.0 - Control: 7.1"
  value    = "Check: Dataset is not publicly accessible"
  # value    = "Enforce: Dataset is not publicly accessible"
}

# GCP > BigQuery > Table > Approved
resource "turbot_policy_setting" "gcp_bigquery_table_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApproved"
  note     = "GCP CIS v2.0.0 - Control: 7.2"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > BigQuery > Table > Approved > Encryption At Rest
resource "turbot_policy_setting" "gcp_bigquery_table_approved_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApprovedEncryptionAtRest"
  note     = "GCP CIS v2.0.0 - Control: 7.2"
  value    = "Customer managed key"
  # value    = "Customer managed key or higher"
  # value    = "Encryption at Rest > Customer Managed Key"
}

# GCP > BigQuery > Table > Approved > Encryption At Rest > Customer Managed Key
resource "turbot_policy_setting" "gcp_bigquery_table_approved_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/tableApprovedEncryptionAtRestCustomerManagedKey"
  note     = "GCP CIS v2.0.0 - Control: 7.2"
  # The ID of your GCP KMS key
  value = "projects/my-project/locations/us-east1/keyRings/my-keyring/cryptoKeys/my-key"
}

# GCP > BigQuery > Dataset > Encryption At Rest
resource "turbot_policy_setting" "gcp_bigquery_dataset_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetEncryptionAtRest"
  note     = "GCP CIS v2.0.0 - Control: 7.3"
  value    = "Check: Customer managed key"
  # value    = "Enforce: Customer managed key"
  # value    = "Check: Encryption at Rest > Customer Managed Key"
  # value    = "Enforce: Encryption at Rest > Customer Managed Key"
}

# GCP > BigQuery > Dataset > Encryption At Rest > Customer Managed Key
resource "turbot_policy_setting" "gcp_bigquery_dataset_encryption_at_rest_customer_managed_key" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetEncryptionAtRestCustomerManagedKey"
  note     = "GCP CIS v2.0.0 - Control: 7.3"
  # The ID of a GCP KMS symmetric key
  value = "projects/parker-aac/locations/us/keyRings/test-cis-keyring/cryptoKeys/test-cis-key"
}
