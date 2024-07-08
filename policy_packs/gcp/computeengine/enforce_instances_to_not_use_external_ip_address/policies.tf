# GCP > Compute Engine > Instance > External IP Addresses
resource "turbot_policy_setting" "gcp_compute_engine_instance_external_ip_address" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceExternalIpAddresses"
  value    = "Check: None"
  # value    = "Enforce: None"
}
