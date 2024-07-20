variable "region_resource" {
  description = "Enter the Turbot Resource ARN for the AWS Region where SSM Documents will be placed. For example: 'arn:aws::us-east-1:123456789012'"
  type    = string
}

variable "ssm_document_role" {
  description = "Enter the AWS IAM Role ARN to be used by SSM to run documents. For example: 'arn:aws:iam::123456789012:role/AmazonSSMRoleForAutomationAssumeQuickSetup'"
  type    = string
}
