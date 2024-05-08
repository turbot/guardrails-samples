terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

variable "logging_bucket" {
  type        = string
  description = "The name of an S3 bucket to which the Guardrails Trail will be delivered. If not provided, Turbot will create one."
  default     = ""
}

variable "encryption_key" {
  type        = string
  description = "The ARN of the KMS key that encrypts the logs delivered by CloudTrail."
}
