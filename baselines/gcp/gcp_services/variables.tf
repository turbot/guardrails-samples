variable "target_resource" {
  type = string
}

# Service names must match the "policy_map" below, you may add any services from the policy_map that you wish to "Enabled" or "Disabled"
variable "service_status" {
  type = map
}

# This is a map of Turbot service enabled policy types to service names.
variable "policy_map" {
  type = map
}

variable "api_policy_map" {
  type = map
}