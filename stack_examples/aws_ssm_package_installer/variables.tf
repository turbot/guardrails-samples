variable "region_resource" {
  description = "Enter the Turbot Resource ARN for the AWS Region where SSM Documents will be placed. I.e.: 'arn:aws::us-east-1:999999999999'"
  type    = string
}

variable "ssm_document_role" {
  description = "Enter the AWS IAM Role ARN to be used by SSM to run documents. I.e.: 'arn:aws:iam::999999999999:role/AmazonSSMRoleForAutomationAssumeQuickSetup'"
  type    = string
}
