# Baseline Configuration
variable "trusted_accounts" {
  type    = list(string)
  default = []
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

variable "enable_aws_sqs_queue_trusted_access" {
  type        = bool
  description = "Enable the SQS queue trusted access policies for baseline"
  default     = false
}

variable "enable_aws_trusted_accounts_template" {
  type        = bool
  description = "Enable the AWS trusted account policies for baseline"
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
