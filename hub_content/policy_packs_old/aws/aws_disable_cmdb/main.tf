# Disable AWS resources from being discovered in the CMDB.

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

provider "turbot" {
  profile = var.turbot_profile
}


## Create Smart Folder at the Turbot level

resource "turbot_smart_folder" "aws_cmdb" {
  parent = "tmod:@turbot/turbot#/"
  title  = "SF - AWS Disable CMDB Policies"
}


## Vars to Map resources to enable or disable CMDB
variable "resource_cmdb" {
  description = "Map of the list of resources that need to be set for CMDB. please update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names. You probably should not modify this:"
  type        = map
}