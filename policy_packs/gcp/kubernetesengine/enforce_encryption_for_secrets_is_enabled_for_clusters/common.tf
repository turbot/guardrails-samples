# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Encryption for Secrets is Enabled for GCP GKE Clusters"
  description = "Delete GCP GKE clusters that do not have encryption for secrets enabled."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Kubernetes Engine > Enabled
resource "turbot_policy_setting" "gcp_kubernetesengine_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/kubernetesEngineEnabled"
  value    = "Enabled"
}
