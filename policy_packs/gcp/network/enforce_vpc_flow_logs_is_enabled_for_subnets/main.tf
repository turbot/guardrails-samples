resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable VPC Flow Logs for Subnets in GCP VPC Network"
  description = "Ensure that enablement of VPC Flow Logs for subnets in a GCP VPC network is crucial for maintaining visibility and security."
  akas        = ["gcp_network_enforce_vpc_flow_logs_is_enabled_for_subnets"]
}
