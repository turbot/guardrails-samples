# AWS Approved Region Policies
# This baseline needs to be considered carefully in conjunction with the AWS > Regions policy set in the AWS Check Baseline
# If the AWS Check Baseline just enables 1 region, approving regions will not be effective as Turbot only discovers in 1 region
# Turbot also supports AWS Lockdown / Boundary policies to limit access to regions -- not part of this baseline.
# More Info: https://turbot.com/v5/docs/guides/regions#approved-regions

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder

resource "turbot_smart_folder" "aws_regions" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Check Regions Policies"
}


## Vars to Map resources to tag
variable "resource_approved_regions" {
  description = "Map of the list of approved regions controls. Update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names."
  type        = map
}
