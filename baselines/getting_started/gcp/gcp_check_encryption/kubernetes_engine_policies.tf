###  Kubernetes Engine Region Cluster Unencrypted 
resource "turbot_policy_setting" "gcp_kubernetesengine_region_cluster_approved" {
  count    = var.enable_kubernetesengine_region_cluster_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_kubernetesengine_region_cluster_approved_encryption_at_rest" {
  count    = var.enable_kubernetesengine_region_cluster_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}

###  Kubernetes Engine Zone Cluster Unencrypted 
resource "turbot_policy_setting" "gcp_kubernetesengine_zone_cluster_approved" {
  count    = var.enable_kubernetesengine_zone_cluster_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneClusterApproved"
  value    = "Check: Approved"
          # "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_kubernetesengine_zone_cluster_approved_encryption_at_rest" {
  count    = var.enable_kubernetesengine_zone_cluster_approved_encryption_at_rest_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_encryption.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneClusterApprovedEncryptionAtRest"
  value    = "Google managed key"
          # "Google managed key"
          # "Google managed key or higher"
          # "Customer managed key"
          # "Customer managed key or higher"
          # "Encryption at Rest > Customer Managed Key"
}