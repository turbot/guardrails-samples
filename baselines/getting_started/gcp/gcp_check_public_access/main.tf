# Check for Public Access controls.

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "gcp_public_access" {
  parent = "tmod:@turbot/turbot#/"
  title  = "GCP Check Public Access Policies"
}

variable "policy_map" {
  description = "This is a map of Turbot policy types for Trusted Access"
  type        = map
}