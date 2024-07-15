resource "turbot_policy_pack" "main" {
  title       = "Check If Creation of Default VPC Network Is Disabled at the GCP Organization Level"
  description = "Ensure that each project within the organization uses purpose-built VPC networks with specific configurations and security controls, reducing the risk of misconfigurations."
  parent      = "tmod:@turbot/turbot#/"
}
