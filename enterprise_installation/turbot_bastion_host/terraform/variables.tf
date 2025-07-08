variable "bastion_host_name" {
  description = "Name for the Bastion Host instance and associated resources"
  type        = string
  default     = "turbot-bastion-host"
}

variable "region" {
  description = "AWS region to deploy the Bastion Host into. If not specified, Terraform will use the region from the AWS_REGION environment variable, or (if not set) from your AWS CLI config or profile."
  type        = string
  default     = null
}

variable "public_subnet_id" {
  description = "ID of the public subnet to launch the Bastion Host in"
  type        = string
}

variable "latest_ami_ssm_param" {
  description = "SSM Parameter name for the latest AMI ID"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the Bastion Host"
  type        = string
  default     = "t3.large"
}

variable "root_volume_size" {
  description = "Size (in GB) of the root EBS volume for the Bastion Host"
  type        = number
  default     = 100
}

variable "alternative_iam_role" {
  description = "Optional IAM role name to use instead of creating a new one"
  type        = string
  default     = ""
}

variable "use_public_ipv4_address" {
  description = "Whether to associate a public IPv4 address with the Bastion Host"
  type        = bool
  default     = true
}

# Previously missing optional variables
variable "cloudwatch_log_group_name" {
  description = "Optional: Name of the CloudWatch Log Group for logging"
  type        = string
  default     = ""
}

variable "s3_bucket_with_prefix" {
  description = "Optional: Prefix of the S3 bucket to which logs are written"
  type        = string
  default     = ""
}

variable "kms_encryption_key_arn" {
  description = "Optional: ARN of the KMS key to allow decryption permissions"
  type        = string
  default     = ""
}

variable "public_ipv4_address" {
  description = "Assign a Public IPv4 Address to the bastion host. If set to false, will try to connect over Private IPv4 address."
  type        = string
  default     = "true"
}