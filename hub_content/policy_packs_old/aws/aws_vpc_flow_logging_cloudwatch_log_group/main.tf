terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

variable "vpc_flow_logging_s3_key_bucket_prefix" {
  type        = string
  description = "VPC flow logging S3 bucket key prefix."
}
