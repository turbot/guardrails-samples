# GCP > Network > Backend Service > Logging
resource "turbot_policy_setting" "gcp_network_backend_service_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/backendServiceLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.16"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# GCP > Network > Backend Service > Logging > Sample Rate
resource "turbot_policy_setting" "gcp_network_backend_service_logging_sample_rate" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/backendServiceLoggingSampleRate"
  note     = "GCP CIS v2.0.0 - Control: 2.16"
  value    = 1
}