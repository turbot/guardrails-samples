# GCP > Kubernetes Engine > Region Cluster > Approved
resource "turbot_policy_setting" "gcp_kubernetesengine_region_cluster_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Kubernetes Engine > Region Cluster > Approved > Custom
resource "turbot_policy_setting" "gcp_kubernetesengine_region_cluster_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterApprovedCustom"
  template_input = <<-EOT
    {
      regionCluster {
        databaseEncryption: get(path: "databaseEncryption")
        databaseEncryptionState: get(path: "databaseEncryption.state")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.regionCluster.databaseEncryptionState == "ENCRYPTED" -%}
      title: Encryption of secrets at the application layer
      result: Approved
      message: "GKE region clusters secrets are encrypted at the application layer"
    {%- else -%}
      title: Encryption of secrets at the application layer
      result: Not approved
      message: "GKE region clusters secrets are not encrypted at the application layer"
    {%- endif -%}
    EOT
}

# GCP > Kubernetes Engine > Zone Cluster > Approved
resource "turbot_policy_setting" "gcp_kubernetesengine_zone_cluster_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneClusterApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Kubernetes Engine > Zone Cluster > Approved > Custom
resource "turbot_policy_setting" "gcp_kubernetesengine_zone_cluster_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneClusterApprovedCustom"
  template_input = <<-EOT
    {
      zoneCluster {
        databaseEncryption: get(path: "databaseEncryption")
        databaseEncryptionState: get(path: "databaseEncryption.state")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.zoneCluster.databaseEncryptionState == "ENCRYPTED" -%}
      title: Encryption of secrets at the application layer
      result: Approved
      message: "GKE zone clusters secrets are encrypted at the application layer"
    {%- else -%}
      title: Encryption of secrets at the application layer
      result: Not approved
      message: "GKE zone clusters secrets are not encrypted at the application layer"
    {%- endif -%}
    EOT
}
