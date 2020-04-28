variable "target_resource" {
  description = "Enter a target_resource to set the policies on a specific resource. This can be an AKA or resource id:"
  type        = string
}

# Enter the list of providers that you would like to "Skip", "Check: Not Registered", "Check: Registered", "Enforce: Not Registered" or "Enforce: Registered".
# Service names must match the "policy_map" below.
variable "provider_status" {
  type = map
}

#This is a map of Turbot policy types to service names which should not be modified
variable "provider_registration_map" {
  type = map
}
