# Adding additional Profiles to the Turbot.com Directory
# This baseline is specifically to create profiles in an exisiting turbot.com
# Will grant the Turbot/Owner role to each profile at the Turbot root level
# Will activate each Turbot/Owner grant to each profile

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Vars to Map resources to tag
variable "directory_id" {
    description = "Directory ID where profiles are created"
    type = string
}

variable "user_profile" {
  description = "Map of the list of turbot.com profileIds. Update in terraform.tfvars"
  type        = map
}
