resource "turbot_policy_pack" "main" {
  title       = "Enforce Approved Models and GPUs for GCP Vertex AI"
  description = "Check that GCP Vertex AI Model Registry models are approved — by Model Garden provenance, by an approval label, by a time-boxed exception label, or by an explicit per-source-type allowlist — and that every endpoint serves only approved models, on approved GPU types, within a replica limit."
  akas        = ["gcp_vertexai_enforce_approved_models_and_gpu"]
}
