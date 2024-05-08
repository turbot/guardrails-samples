terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  profile = var.guardrails_profile
}

variable "guardrails_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "ec2_instance_profile" {
  description = "EC2 Instance Profile name; not the full ARN for the IAM role."
  type        = string
}
