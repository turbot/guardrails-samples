resource "turbot_policy_pack" "main" {
  title       = "Enforce Approved Models for GCP Vertex AI"
  description = "Check that GCP Vertex AI Model Registry models are approved — by Model Garden provenance, by an approval label, by a time-boxed exception label, or by an explicit per-source-type allowlist — and that every model deployed on a Vertex AI endpoint is an approved model."
  akas = [
    "gcp_vertexai_enforce_approved_models",
    "gcp_vertexai_enforce_endpoint_model_versions"
  ]
}
