variable "region_arn" {
  description = "Enter the Turbot Resource ARN for the AWS Region where SSM Documents will be placed."
  type    = string
}

variable "ssm_document_role_arn" {
  description = "Enter the AWS IAM Role ARN to be used by SSM to run documents."
  type    = string
}
