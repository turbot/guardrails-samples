variable "service_status" {
  description = "Enter the list of services that you would like to Enable or Disable, Service names must match the policy_map:"
  type        = map(any)
}

variable "enabled_policy_map" {
  description = "This is a map of Turbot policy types to service names. You probably should not modify this."
  type        = map(any)
}

variable "api_policy_map" {
  description = "This is a map of service API enabled policy types to service names. It is advised not to modify the below list."
  type        = map(any)
}





