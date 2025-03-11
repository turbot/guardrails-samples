variable "trusted_access_controls" {
  description = "List of resource types for trusted access policies and which enforcement option to choose."
  type = map(string)
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