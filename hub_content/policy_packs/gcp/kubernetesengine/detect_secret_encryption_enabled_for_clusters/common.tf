# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect that encryption of Kubernetes secrets is enabled for GKE clusters"
  description = "Detect that encryption of Kubernetes secrets is enabled for GKE clusters"
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Kubernetes Engine > Enabled
resource "turbot_policy_setting" "gcp_kubernetesengine_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/kubernetesEngineEnabled"
  value    = "Enabled"
}
