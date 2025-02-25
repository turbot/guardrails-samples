variable "servicenow_mod_list_aws" {
  type = list(string)
  default = [
    #####################################
    #########  ServiceNow AWS  ##########
    #####################################
    "servicenow-aws",
    "servicenow-aws-cloudtrail",
    "servicenow-aws-cloudwatch",
    "servicenow-aws-ec2",
    "servicenow-aws-iam",
    "servicenow-aws-kms",
    "servicenow-aws-rds",
    "servicenow-aws-s3",
    "servicenow-aws-vpc-connect",
    "servicenow-aws-vpc-core",
    "servicenow-aws-vpc-internet",
    "servicenow-aws-vpc-security"
  ]
}
