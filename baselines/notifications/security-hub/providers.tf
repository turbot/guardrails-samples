
terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
  required_version = ">= 0.13"
}

provider "turbot" {
  profile = var.turbot_profile
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "SecurityHub Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = <<-DEFAULT
  Defines the sets of policies require to configure Turbot to push out notifications.
  These notifications will be transformed and persisted as SecurityHub findings.
  DEFAULT
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent resource of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
