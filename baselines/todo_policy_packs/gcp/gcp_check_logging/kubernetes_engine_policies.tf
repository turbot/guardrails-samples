# GCP > Kubernetes Engine > Region Cluster > Logging
# https://turbot.com/v5/mods/turbot/gcp-kubernetesengine/inspect#/policy/types/regionClusterLogging
resource "turbot_policy_setting" "gcp_kubernetes_engine_region_cluster_logging" {
  count    = var.enable_kubernetes_engine_region_cluster_logging_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterLogging"
  value    = "Check: Enabled"
            # "Skip"
            # "Check: Disabled"
            # "Check: Enabled"
            # "Enforce: Disabled"
            # "Enforce: Enabled"
}
