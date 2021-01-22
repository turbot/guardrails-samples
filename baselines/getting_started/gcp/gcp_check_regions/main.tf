# GCP Approved Region Policies
# More Info: https://turbot.com/v5/docs/guides/regions#approved-regions

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "gcp_regions" {
  parent = "tmod:@turbot/turbot#/"
  title  = "GCP Check Regions Policies"
}


## Vars to Map resources to tag
variable "resource_approved_regions" {
  description = "Map of the list of approved regions controls. please update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names."
  type        = map
}
