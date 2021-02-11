# Baseline Configuration

variable "enable_backup_vault_approved_policies" {
  type        = bool
  description = "Enable the Backup Vault approved policies for baseline"
  default     = false
}

variable "enable_backup_vault_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Backup Vault Resources, by default this is disabled"
  default     = false
}

variable "enable_dynamodb_table_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on DynamoDB Table Resources, by default this is disabled"
  default     = false
}

variable "enable_redshift_cluster_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Redshift Cluster Resources, by default this is disabled"
  default     = false
}

variable "enable_ssm_parameter_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on SSM Parameter Resources, by default this is disabled"
  default     = false
}

variable "enable_secretmanager_secret_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Secret Manager Secret Resources, by default this is disabled"
  default     = false
}

variable "enable_rds_instance_approved_policies" {
  type        = bool
  description = "Enable the RDS Instance approved policies for baseline"
  default     = false
}

variable "enable_rds_instance_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on RDS Instance Resources, by default this is disabled"
  default     = false
}

variable "enable_rds_manualsnapshot_approved_policies" {
  type        = bool
  description = "Enable the RDS Instance approved policies for baseline"
  default     = false
}

variable "enable_rds_manualsnapshot_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on RDS Manual Snapshot, by default this is disabled"
  default     = false
}

variable "enable_efs_filesystem_approved_policies" {
  type        = bool
  description = "Enable the EFS Filesystem approved policies for baseline"
  default     = false
}

variable "enable_sqs_queue_encryption_policies" {
  type        = bool
  description = "Enable the SQS Queue approved policies for baseline"
  default     = false
}

variable "enable_efs_filesystem_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on EFS Filesystem Resources, by default this is disabled"
  default     = false
}

variable "enable_elasticsearch_domain_approved_policies" {
  type        = bool
  description = "Enable the Elasticsearch Domain approved policies for baseline"
  default     = false
}

variable "enable_elasticsearch_domain_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Elasticsearch Domain Resources, by default this is disabled"
  default     = false
}

# None

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Encryption Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the baseline AWS Check Encryption"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
