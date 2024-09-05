resource "turbot_policy_pack" "main" {
  title       = "Enforce Default VPC Network Is Not Used in GCP Projects"
  description = "Encourage the creation of tailored VPC networks with specific configurations and security controls, reducing the risk of misconfigurations and enhancing overall network security."
  akas        = ["gcp_network_enforce_default_vpc_network_is_not_used_in_projects"]
}
