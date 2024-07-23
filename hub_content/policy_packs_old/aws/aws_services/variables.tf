variable "target_resource" {
  description = "Enter a target_resource to set the policies on a specific resource(turbot,folder,aws account). This can be an AKA or resource id:"
  type        = string
}
variable "service_status" {
  description = "Enter the list of services that you would like to Enable or Disable, Service names must match the policy_map:"
  type        = map
}
variable "policy_map" {
  description = "This is a map of Turbot policy types to service names. You probably should not modify this:"
  type        = map
}