# Tagging Baseline that sets a default template to be edited per use case
# If you associate as is, all resoures will alarm given the tagging template is specific
# More Info: https://turbot.com/v5/docs/concepts/guardrails/tagging


variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}

## Create Smart Folder at the Turbot level

resource "turbot_smart_folder" "azure_tagging" {
  parent = "tmod:@turbot/turbot#/"
  title  = "Azure Check Tagging Policies"
}

## Vars to Map resources to tag
variable "resource_tags" {
  description = "Map of the list of resources that need to be tagged. Update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names"
  type        = map
}

variable "policy_map_template" {
  description = "This is a map of Turbot tag template policy types to service names"
  type        = map
}



## ## Description: Sets default tag template to validate 3 Tags:
##     Primaryowner:    Must exist
##     Secondaryowner:  Must exist
##     Costcenterid:    Must exist
##     Name/Usage:      Must exist
##
## If the tags do not exist, we will create them with a default
## value pulled from the enclosing turbot folder.
##
## If the enclosing folder has no default value then the resource 
## will be tagged with "__Missing Tag__"

#For Missing Tag use case
##variable "required_tags" {
##  description = "This is a list of tag names that must exist on all resources."
##  type        = list(string)
##}