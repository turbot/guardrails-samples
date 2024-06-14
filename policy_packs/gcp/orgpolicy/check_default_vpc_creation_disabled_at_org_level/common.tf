# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Check If Creation of Default VPC Network Is Disabled at the GCP Organization Level"
  description = "Ensure that creation of default VPC network is disabled at the GCP organization level."
  parent      = "tmod:@turbot/turbot#/"
}

