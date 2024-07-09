variable "kms_key_alias" {
  type        = string
  description = "The alias of the KMS key that encrypts the logs delivered by CloudTrail. To be used for control 3.1."
  default     = "alias/turbot/default"
}

variable "logging_bucket" {
  type        = string
  description = "The name of an S3 bucket to which the CloudTrail will deliver the logs. To be used for controls 3.1 and 3.4."
  default     = ""
}
