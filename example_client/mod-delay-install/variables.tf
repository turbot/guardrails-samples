variable "backoff_duration" {
  type        = string
  description = "Time to wait for between each mod install"
  default     = "300s"
}

variable "turbot_profile" {
  type = string
  description = "Turbot profile to use"
}