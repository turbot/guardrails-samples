# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Check if the creation of the default VPC network is disabled at the GCP organization level"
  description = "Ensure that the creation of the default VPC network is disabled at the GCP organization level."
  parent      = "tmod:@turbot/turbot#/"
}

