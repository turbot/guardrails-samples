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
        databaseEncryptionState: get(path: "databaseEncryption.state")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.regionCluster.databaseEncryptionState == "ENCRYPTED" -%}

      {%- set data = { 
          title: "Encryption for Secrets"
          result: Approved
          message: "Encryption for secrets is enabled"
      } -%} 

    {%- elif $.regionCluster.databaseEncryptionState != "ENCRYPTED" -%}

      {%- set data = { 
          title: "Encryption for Secrets"
          result: "Not approved"
          message: "Encryption for secrets is not enabled"
      } -%} 

    {%- else -%}

      {%- set data = { 
          title: "Encryption for Secrets"
          result: "Skip"
          message: "No data for encryption yet"
      } -%} 

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
        databaseEncryptionState: get(path: "databaseEncryption.state")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.zoneCluster.databaseEncryptionState == "ENCRYPTED" -%}

      {%- set data = { 
          title: "Encryption for Secrets"
          result: Approved
          message: "Encryption for secrets is enabled"
      } -%} 

    {%- elif $.zoneCluster.databaseEncryptionState != "ENCRYPTED" -%}

      {%- set data = { 
          title: "Encryption for Secrets"
          result: "Not approved"
          message: "Encryption for secrets is not enabled"
      } -%} 

    {%- else -%}

      {%- set data = { 
          title: "Encryption for Secrets"
          result: "Skip"
          message: "No data for encryption yet"
      } -%} 

    {%- endif -%}
    EOT
}
