###  Dataproc Cluster Unencrypted 
resource "turbot_policy_setting" "gcp_dataproc_cluster_approved" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}


resource "turbot_policy_setting" "gcp_dataproc_cluster_approved_encryption_at_rest" {
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}