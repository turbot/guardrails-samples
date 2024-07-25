variable "aws_profile" {
  description = "The AWS profile against which the script will be executed. Leaving this value blank will use the default profile."
  type        = string
  default     = "" # AWS Profile to use, leave blank to use default profile"
}

variable "aws_region" {
  description = "The region where AWS operations will take place."
  type        = string
  default     = "us-east-2" # Can be any AWS region, please update as per the need.
}

variable "sns_topic_name" {
  description = "Name the AWS SNS Topic to which the Turbot notifications will be published."
  type        = string
  default     = "turbot_firehose_topic" # Review/Update
}

variable "aws_iam_username" {
  description = "Name the AWS IAM User which will be used by Turbot for authentication."
  type        = string
  default     = "turbot_firehose_user" # Review/Update
}

variable "aws_iam_user_policy" {
  description = "Name the AWS IAM User Policy which will be used by Turbot for authentication."
  type        = string
  default     = "turbot_firehose_user_policy" # Review/Update
}
