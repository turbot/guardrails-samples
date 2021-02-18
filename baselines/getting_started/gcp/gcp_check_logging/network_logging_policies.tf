# GCP > Network > Firewall > Logging
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/firewallLogging
resource "turbot_policy_setting" "gcp_network_firewall_logging" {
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallLogging"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Disabled"
  # "Enforce: Enabled"
}


# GCP > Network > Backend Service > Logging
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/regionBackendServiceLogging
resource "turbot_policy_setting" "gcp_network_backend_service_logging" {
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-network#/policy/types/backendServiceLogging"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Disabled"
  # "Enforce: Enabled"
}

# GCP > Network > Backend Service > Logging > Sample Rate
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/regionBackendServiceLoggingSampleRate
# Sampling rate of requests to the load balancer 
# Where 1 means all logged requests are reported
# Where 0 means no logged requests are reported
resource "turbot_policy_setting" "gcp_network_backend_service_logging_sammple_rate" {
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-network#/policy/types/backendServiceLoggingSampleRate"
  value    = "1"
}


# GCP > Network > Region Backend Service > Logging
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/regionBackendServiceLogging
resource "turbot_policy_setting" "gcp_network_region_backend_service_logging" {
  count    = var.enable_network_region_backend_service_logging_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-network#/policy/types/regionBackendServiceLogging"
  value    = "Check: Enabled"
  # "Skip"
  # "Check: Disabled"
  # "Check: Enabled"
  # "Enforce: Disabled"
  # "Enforce: Enabled"
}

# GCP > Network > Region Backend Service > Logging > Sample Rate
# https://turbot.com/v5/mods/turbot/gcp-network/inspect#/policy/types/regionBackendServiceLoggingSampleRate
# Sampling rate of requests to the load balancer 
# Where 1 means all logged requests are reported
# Where 0 means no logged requests are reported
resource "turbot_policy_setting" "gcp_network_region_backend_service_logging_sammple_rate" {
  count    = var.enable_network_region_backend_service_logging_sammple_rate_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_logging.id
  type     = "tmod:@turbot/gcp-network#/policy/types/regionBackendServiceLoggingSampleRate"
  value    = "1"
}
