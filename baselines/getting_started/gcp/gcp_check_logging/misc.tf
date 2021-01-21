# GCP > Kubernetes Engine > Region Cluster > Logging
resource "turbot_policy_setting" "gcp_kubernetes_engine_region_cluster_logging" {
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterLogging"
  value    = "Check: Enabled"
          # "Skip"
          # "Check: Disabled"
          # "Check: Enabled"
          # "Enforce: Disabled"
          # "Enforce: Enabled"
}

# GCP > SQL > Instance > Binary Log
resource "turbot_policy_setting" "gcp_instance_binary_log" {
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/binaryLogEnabled"
  value    = "Check: Enabled"
          # "Skip"
          # "Check: Disabled"
          # "Check: Enabled"
          # "Enforce: Disabled"
          # "Enforce: Enabled"
}