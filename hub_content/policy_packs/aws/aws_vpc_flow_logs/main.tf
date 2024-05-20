terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

variable "policy_pack_title" {
  type        = string
  description = "Title for the policy pack."
}

variable "vpc_flow_logging_s3_key_bucket_prefix" {
  type        = string
  description = "VPC flow logging S3 bucket key prefix."
}
