variable "policy_setting" {
  description = "The Turbot policy setting mode. e.g. Check, Enforce"
  default     = "Check"
}

variable "target_resource" {
  description = "The target resource to attach the policy pack to. e.g. tmod:@turbot/turbot#/"
}

variable "trusted_account_ids" {
  description = "List of AWS account IDs that should be trusted for access"
  type        = list(string)
  default     = []
}

variable "trusted_access_policies" {
  description = "Map of trusted access policy types to their policy values"
  type        = map(string)
}

variable "trusted_access_accounts_policies" {
  description = "Map of trusted access policy types to their corresponding accounts policy types"
  type        = map(string)
}

variable "trusted_access_exceptions_config" {
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