variable "exception_duration_hours" {
  description = "Number of hours the security group exceptions (SSH/RDP access) should remain active"
  type        = number
  default     = 1

  validation {
    condition     = var.exception_duration_hours > 0 && var.exception_duration_hours <= 168
    error_message = "Exception duration must be between 1 and 168 hours (1 week)."
  }
}

variable "enable_time_limited_exceptions" {
  description = "Whether to enable time-limited exceptions for SSH/RDP access"
  type        = bool
  default     = true
}
