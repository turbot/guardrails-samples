variable "turbot_profile" {
  description = "Profile that has access into the desired workspace."
}

variable "logging_buckets" {
  description = "Boolean value to turn on regional logging buckets.  Should be true if you don't have a logging solution already."
  type        = bool
}

variable "service_roles" {
  description = "Boolean value to turn on Turbot provisioned service roles.  "
  type        = bool
}

variable "turbot_cloudtrails" {
  description = "Boolean value to turn on the Turbot CloudTrails. Only enable this if you don't already have a CloudTrail in your environment."
  type        = bool
}

variable "event_handlers_enabled" {
  description = "Boolean value to turn on the Turbot Event Handlers"
  type        = bool
}

variable "event_handlers_prefix" {
  description = "Boolean value to turn on the Turbot Event Handlers.  Applies to SNS topic and Event Rule."
  type        = string
  default     = null
}

variable "logging_bucket_prefix" {
  description = "Prefix for the Turbot Logging Buckets. Defaults value out of the box from Turbot V5 to 'turbot-'.  Applies to buckets and cloudtrails."
  type        = string
  default     = null
}

variable "turbot_cloudtrails_prefix" {
  description = "Prefix for the Turbot-managed CloudTrail. Defaults value out of the box from Turbot V5 to 'turbot-'.  Applies to buckets and cloudtrails."
  type        = string
  default     = null
}

variable "aws_approved_regions" {
  description = "YAML list of approved AWS regions."
  type        = list(string)
  default     = null
}
