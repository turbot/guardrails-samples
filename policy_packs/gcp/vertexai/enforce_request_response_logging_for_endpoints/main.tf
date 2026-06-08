resource "turbot_policy_pack" "main" {
  title       = "Enforce Request-Response Logging for GCP Vertex AI Endpoints"
  description = "Capture an audit trail of GCP Vertex AI endpoint predictions by requiring request-response logging to be enabled."
  akas        = ["gcp_vertexai_enforce_request_response_logging_for_endpoints"]
}
