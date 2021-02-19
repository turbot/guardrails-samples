variable "aws_profile" {
  description = "AWS profile used to install the SecurityHub baseline on the account managed by the profile"
  type        = string
}

variable "aws_region" {
  description = "Configures which AWS region SecurityHub baseline resources are created"
  type        = string
}

variable "vpc_id" {
  description = <<-DESC
    This setting is only used if the variable enabled_caching is set to true.
    When he VPC id is not empty, the script will attempt to install the Lamdba and memcached resources onto this VPC.
    If this value is empty then the script will create a new VPC.
  DESC
  type        = string
  default     = ""
}

variable "public_subnet_id" {
  description = <<-DESC
  TODO
  DESC
  type        = string
  default     = ""
}

variable "private_subnet_id" {
  description = <<-DESC
  TODO
  DESC
  type        = string
  default     = ""
}

variable "enabled_caching" {
  type        = bool
  description = <<-DESC
  If the variable is set to false then the script installs the notification queue only and Lambda handler only.
  If the variable is set to trye then the script installs the notification queue, Lambda handler only and memcache to 
  cache the last results to manage network race conditions.
  DESC
  default     = true
}

variable "batch_size" {
  description = "Maximum notification batch size to process to SecurityHub findings"
  default     = "100"
}

variable "batch_window" {
  description = "Maximum notification batch waiting winding to collect notification in order to process to SecurityHub findings"
  default     = "30"
}

variable "turbot_profile" {
  description = "Turbot profile used to install policies for a workspace managed by the profile"
  type        = string
  default     = "default"
}

variable "rebuild" {
  description = <<-DESC
  This setting will rebuild the deployment package to be uploaded to lambda and requires bash.

  Useful in development phase.
  DESC
  type        = bool
  default     = false
}
