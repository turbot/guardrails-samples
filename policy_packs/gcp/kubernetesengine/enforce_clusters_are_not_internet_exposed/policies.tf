# GCP > Kubernetes Engine > Region Cluster > Master Authorized Networks Config
resource "turbot_policy_setting" "gcp_kubernetesengine_region_cluster_master_authorized_networks_config" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterMasterAuthorizedNetworksConfig"
  value    = "Check: Enabled"
  # value    = "Enforce: Disabled"
  # value    = "Enforce: Enabled"
}

# GCP > Kubernetes Engine > Zone Cluster > Master Authorized Networks Config
resource "turbot_policy_setting" "gcp_kubernetesengine_zone_cluster_master_authorized_networks_config" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneClusterMasterAuthorizedNetworksConfig"
  value    = "Check: Enabled"
  # value    = "Enforce: Disabled"
  # value    = "Enforce: Enabled"
}
