# Enter a target_resource to set the policies on a specific resource(turbot,folder,aws account). This can be an AKA or resource id.
variable "target_resource" {
  type    = string
}
# Enter the list of services that you would like to "Enabled" or "Disabled"
# Service names must match the "policy_map" below
variable "service_status" {
  type = map
}
# This is a map of Turbot policy types to service names. You probably should not modify this.
variable "policy_map" {
  type = map
}