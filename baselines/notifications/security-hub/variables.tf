variable "turbot_profile" {
  description = "Turbot profile used to install policies for a workspace managed by the profile"
}


variable "aws_profile" {
  description = "AWS profile used to install the SecurityHub baseline on the account managed by the profile"
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "Configures which AWS region SecurityHub baseline resources are created"
  type        = string
}
