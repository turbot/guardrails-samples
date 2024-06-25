resource "turbot_smart_folder" "pack" {
  title       = "Enforce Default VPC Network Is Not Used Within GCP Projects"
  description = "Encourage the creation of tailored VPC networks with specific configurations and security controls, reducing the risk of misconfigurations and enhancing overall network security."
  parent      = "tmod:@turbot/turbot#/"
}
