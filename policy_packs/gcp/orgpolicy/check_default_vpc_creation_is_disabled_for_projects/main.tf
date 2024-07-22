resource "turbot_policy_pack" "main" {
  title       = "Check If Creation of Default VPC Network Is Disabled at the GCP Organization Level"
  description = "Ensure that each project within the organization uses purpose-built VPC networks with specific configurations and security controls, reducing the risk of misconfigurations."
  akas        = ["gcp_orgpolicy_check_default_vpc_creation_is_disabled_for_projects"]
}
