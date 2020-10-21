variable "resource_tags" {
  description = "Map of the list of resources that need to be tagged. please update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names. You probably should not modify this:"
  type        = map
}
