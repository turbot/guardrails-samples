###  Dataproc Cluster Unencrypted 
# GCP > Dataproc > Cluster > Approved
# https://turbot.com/v5/mods/turbot/gcp-dataproc/inspect#/policy/types/clusterApproved
resource "turbot_policy_setting" "gcp_dataproc_cluster_approved" {
  count    = var.enable_dataproc_cluster_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

# GCP > Dataproc > Cluster > Approved > Encryption at Rest
# https://turbot.com/v5/mods/turbot/gcp-dataproc/inspect#/policy/types/clusterApprovedEncryptionAtRest
resource "turbot_policy_setting" "gcp_dataproc_cluster_approved_encryption_at_rest" {
  count    = var.enable_dataproc_cluster_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}