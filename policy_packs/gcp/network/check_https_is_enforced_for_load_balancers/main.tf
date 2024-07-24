resource "turbot_policy_pack" "main" {
  title       = "Check GCP Network Load Balancers Enforce HTTPS for Encrypted Web Traffic"
  description = "Ensure that the data transmitted between clients and load-balanced applications is encrypted, protecting it from interception and unauthorized access."
  akas        = ["gcp_network_check_https_is_enforced_for_load_balancers"]
}
