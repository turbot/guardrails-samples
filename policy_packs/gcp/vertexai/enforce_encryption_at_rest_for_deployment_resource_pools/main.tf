resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest for GCP Vertex AI Deployment Resource Pools"
  description = "Protect data on GCP Vertex AI deployment resource pools by requiring an approved encryption at rest configuration."
  akas        = ["gcp_vertexai_enforce_encryption_at_rest_for_deployment_resource_pools"]
}
