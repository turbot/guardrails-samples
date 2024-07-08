variable "logging_bucket" {
  type        = string
  description = "The name of an S3 bucket to which the Guardrails Trail will be delivered. If not provided, Turbot will create one."
  default     = ""
}

variable "kms_key_alias" {
  type        = string
  description = "The Alias of the KMS key that encrypts the logs delivered by CloudTrail."
  default     = "alias/turbot/default"
}
