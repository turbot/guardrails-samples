resource "turbot_policy_pack" "main" {
  title       = "Enforce Logging Is Enabled for GCP Network Firewalls"
  description = "Ensure that only necessary and specific ports are open for inbound traffic, minimizing the risk of unauthorized access and potential attacks."
  akas        = ["gcp_network_enforce_logging_is_enabled_for_firewalls"]
}
