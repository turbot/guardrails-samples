variable "logging_buckets" {
  description = "Boolean value to turn on regional logging buckets.  Should be true if you don't have a logging solution already."
  type = bool
}

variable "service_roles" {
  description = "Boolean value to turn on Turbot provisioned service roles.  "
  type = bool
}

variable "turbot_cloudtrails" {
  description = "Boolean value to turn on the Turbot CloudTrails"
  type = bool
}

variable "event_handlers_enabled" {
  description = "Boolean value to turn on the Turbot Event Handlers"
  type = bool
}

variable "event_handlers_prefix" {
  description = "Boolean value to turn on the Turbot Event Handlers.  Applies to SNS topic and Event Rule."
  type = string
}

variable "logging_bucket_prefix" {
  description = "Prefix for the Turbot Logging Buckets. Defaults to 'turbot-'.  Applies to buckets and cloudtrails."
  type = string
}
