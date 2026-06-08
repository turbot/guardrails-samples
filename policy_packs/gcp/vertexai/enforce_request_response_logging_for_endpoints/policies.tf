# GCP > Vertex AI > Endpoint > Active > Request-Response Logging
resource "turbot_policy_setting" "gcp_vertexai_endpoint_active_request_response_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-vertexai#/policy/types/endpointActiveRequestResponseLogging"
  value    = "Check: Enabled"
}
