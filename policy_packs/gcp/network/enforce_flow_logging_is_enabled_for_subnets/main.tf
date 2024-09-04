resource "turbot_policy_pack" "main" {
  title       = "Enforce Flow Logging is Enabled for GCP VPC Subnetworks"
  description = "Enforcing flow logging for GCP VPC subnetworks is essential for monitoring and analyzing network traffic, helping to identify potential security threats, performance issues, and ensuring compliance with security policies."
  akas        = ["gcp_network_enforce_flow_logging_is_enabled_for_subnets"]
}
