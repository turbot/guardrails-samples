# The policy value to use when no effective encryption-in-transit statement is found.
# Use "Check: Enabled" for testing (observe alarms without remediation).
# Use "Enforce: Enabled" for production (auto-add canonical statement).
variable "enforcement_level" {
  type        = string
  description = "Policy value when no effective EIT statement is found"
  default     = "Enforce: Enabled"

  validation {
    condition     = contains(["Check: Enabled", "Enforce: Enabled"], var.enforcement_level)
    error_message = "Must be \"Check: Enabled\" or \"Enforce: Enabled\"."
  }
}
