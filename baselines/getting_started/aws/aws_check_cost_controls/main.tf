# Simple Cost Controls that can be applied for:
# Checking Age of infrastructure over X days
# Checking unattached volumes
# Setting resource scheduling.


variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder at the Turbot level

resource "turbot_smart_folder" "aws_cost_controls" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Check Cost Controls Policies"
}

## Vars to Map resources to Active policies
variable "resource_active" {
  description = "Map of the list of resources that need to be set to Active. Update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names."
  type        = map
}

variable "policy_map_age" {
  description = "This is a map of Turbot policy types to service names for Age policies."
  type        = map
}