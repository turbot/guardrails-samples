variable "enforce_smart_retention" {
  description = "Enter the name for the local directory to be created:"
  type        = bool
  default     = true
}

variable "min_retention" {
  type    = number
  default = 14
}

variable "max_retention" {
  type    = number
  default = 365
}

variable "purge_limit" {
  type    = number
  default = 30
}

variable "debug_logs" {
  type    = number
  default = 14
}
