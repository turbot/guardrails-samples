# Baseline Configuration
variable "trusted_accounts" {
  type    = list(string)
  default = []
}

variable "enable_aws_ec2_ami_trusted_access" {
  type        = bool
  description = "Enable the EC2 ami trusted access policies for baseline"
  default     = true
}

variable "enable_aws_apigateway_api_approved" {
  type        = bool
  description = "Enable the API Gateway API approved policies for baseline"
  default     = true
}

variable "enable_aws_apigateway_api_approved_usage" {
  type        = bool
  description = "Enable the API Gateway API approved usage policies for baseline"
  default     = true
}

variable "enable_aws_redshift_cluster_public" {
  type        = bool
  description = "Enable the Redshift cluster public access policies for baseline"
  default     = false
}

variable "enable_aws_rds_db_instance_public" {
  type        = bool
  description = "Enable the RDS DB instance public access policies for baseline"
  default     = false
}

variable "enable_aws_redshift_cluster_snapshot_manual_trusted_access" {
  type        = bool
  description = "Enable the Redshift cluster manual snapshot trusted access policies for baseline"
  default     = false
}

variable "enable_aws_rds_db_snapshot_manual_trusted_access" {
  type        = bool
  description = "Enable the RDS DB manual snapshot trusted access policies for baseline"
  default     = false
}

variable "enable_aws_rds_db_cluster_snapshot_manual_trusted_access" {
  type        = bool
  description = "Enable the RDS DB cluster manual snapshot trusted access policies for baseline"
  default     = false
}

variable "enable_ec2_snapshot_trusted_access" {
  type        = bool
  description = "Enable the EC2 snapshot trusted access policies for baseline"
  default     = true
}

variable "enable_ec2_snapshot_approved_usage" {
  type        = bool
  description = "Enable the EC2 snapshot approved usage policies for baseline"
  default     = false
}

variable "enable_aws_ec2_instance_approved_public_ip" {
  type        = bool
  description = "Enable the EC2 instance approved public ip policies for baseline"
  default     = true
}

variable "enable_aws_ec2_instance_metadata_service" {
  type        = bool
  description = "Enable the EC2 instance metadata service policies for baseline"
  default     = true
}

variable "enable_aws_ec2_instance_metadata_service_token_hop_limit" {
  type        = bool
  description = "Enable the EC2 instance metadata service token policies for baseline"
  default     = true
}

variable "enable_aws_lambda_function_approved" {
  type        = bool
  description = "Enable the lambda function approved policies for baseline"
  default     = true
}

variable "enable_aws_lambda_function_approved_usage" {
  type        = bool
  description = "Enable the lambda function approved usage policies for baseline"
  default     = true
}

variable "enable_aws_ec2_alb_approved" {
  type        = bool
  description = "Enable the EC2 application loadbalancer approved policies for baseline"
  default     = true
}

variable "enable_aws_ec2_alb_approved_usage" {
  type        = bool
  description = "Enable the EC2 application loadbalancer approved usage policies for baseline"
  default     = true
}

variable "enable_aws_ec2_elb_approved" {
  type        = bool
  description = "Enable the EC2 classic loadbalancer approved policies for baseline"
  default     = true
}

variable "enable_aws_ec2_elb_approved_usage" {
  type        = bool
  description = "Enable the EC2 classic loadbalancer approved usage policies for baseline"
  default     = true
}

variable "enable_aws_ec2_nlb_approved" {
  type        = bool
  description = "Enable the EC2 network loadbalancer approved policies for baseline"
  default     = true
}

variable "enable_aws_ec2_nlb_approved_usage" {
  type        = bool
  description = "Enable the EC2 network loadbalancer approved usage policies for baseline"
  default     = true
}

variable "enable_aws_route53_hostedzone_approved" {
  type        = bool
  description = "Enable the Route53 hostedzone approved policies for baseline"
  default     = false
}

variable "enable_aws_route53_hostedzone_approved_usage" {
  type        = bool
  description = "Enable the Route53 hostedzone approved usage policies for baseline"
  default     = false
}

variable "enable_aws_s3_account_public_access_block" {
  type        = bool
  description = "Enable the S3 account public access block policies for baseline"
  default     = true
}

variable "enable_aws_s3_account_public_access_block_settings" {
  type        = bool
  description = "Enable the S3 account public access block setting policies for baseline"
  default     = true
}

variable "enable_aws_s3_public_access_block" {
  type        = bool
  description = "Enable the S3 bucket public access block setting policies for baseline"
  default     = true
}

variable "enable_aws_s3_public_access_block_settings" {
  type        = bool
  description = "Enable the S3 bucket public access block setting policies for baseline"
  default     = true
}

variable "enable_aws_vpc_security_group_ingress_rule_approved" {
  type        = bool
  description = "Enable the VPC security group ingress rule approved policies for baseline"
  default     = true
}

variable "enable_aws_vpc_security_group_ingress_rule_approved_cidr_ranges" {
  type        = bool
  description = "Enable the VPC security group ingress rule approved cidr ranges policies for baseline"
  default     = true
}

variable "enable_security_Group_IngressRules_ApprovedRules" {
  type        = bool
  description = "Enable the VPC security group ingress rule approved rules policies for baseline"
  default     = true
}

variable "enable_aws_sns_topic_trusted_access" {
  type        = bool
  description = "Enable the SNS topic trusted access policies for baseline"
  default     = true
}

variable "enable_aws_sqs_queue_trusted_access" {
  type        = bool
  description = "Enable the SQS queue trusted access policies for baseline"
  default     = false
}

variable "enable_aws_vpc_subnet_approved" {
  type        = bool
  description = "Enable the VPC subnet approved policies for baseline"
  default     = true
}

variable "enable_aws_vpc_subnet_approved_usage" {
  type        = bool
  description = "Enable the VPC subnet approved usage policies for baseline"
  default     = true
}

variable "enable_aws_trusted_accounts_template" {
  type        = bool
  description = "Enable the AWS trusted account policies for baseline"
  default     = true
}

variable "enable_aws_vpc_elastic_ip_approved" {
  type        = bool
  description = "Enable the VPC elastic ip approved policies for baseline"
  default     = true
}

variable "enable_aws_vpc_elastic_ip_approved_usage" {
  type        = bool
  description = "Enable the VPC elastic ip approved usage policies for baseline"
  default     = true
}

variable "enable_aws_vpc_igw_approved" {
  type        = bool
  description = "Enable the VPC internet gateway approved policies for baseline"
  default     = true
}

variable "enable_aws_vpc_igw_approved_usage" {
  type        = bool
  description = "Enable the VPC internet gateway approved usage policies for baseline"
  default     = true
}


# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Public Access Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS check S3 baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}


