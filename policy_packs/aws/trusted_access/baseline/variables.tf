variable "trusted_access_controls" {
  description = "List of resource types for trusted access policies and which enforcement option to choose."
  type = map(string)
}

variable "policy_map" {
  description = "Static mapping of resource types to their service, resource name, and policy values (should not be modified)"
  type = map(object({
    service      = string
    resourceName = string
    acctPolicy   = string
    skip         = string
    check        = string
    enforce      = string
  }))
}

variable "trusted_access_exceptions" {
  description = "Configuration for trusted access exceptions with baseline and account-specific settings"
  type = object({
    baseline = list(string)
    accounts = map(list(string))
  })
  default = {
    baseline = []
    accounts = {}
  }
}