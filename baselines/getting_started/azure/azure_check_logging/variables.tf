# Baseline Configuration

variable "azure_sql_server_auditing_policies" {
  type        = bool
  description = "Azure Sql server auditing policies for baseline"
  default     = true
}

variable "azure_sql_server_data_security_polices" {
  type        = bool
  description = "Azure Sql server data security policies for baseline"
  default     = true
}

variable "azure_postgresql_server_auditing_disconnections_polices" {
  type        = bool
  description = "Azure Postgresql server auditing disconnections policies for baseline"
  default     = true
}

variable "azure_sql_database_auditing_polices" {
  type        = bool
  description = "Azure Sql database auditing policies for baseline"
  default     = true
}

variable "azure_sql_database_data_security_polices" {
  type        = bool
  description = "Azure Sql database data security policies for baseline"
  default     = true
}

variable "azure_postgresql_server_auditing_polices" {
  type        = bool
  description = "Azure Postgresql server auditing policies for baseline"
  default     = true
}

variable "azure_postgresql_server_auditing_checkpoints_polices" {
  type        = bool
  description = "Azure Postgresql server auditing checkpoints policies for baseline"
  default     = true
}

variable "azure_postgresql_server_auditing_connections_polices" {
  type        = bool
  description = "Azure Postgresql server auditing connections policies for baseline"
  default     = true
}

variable "azure_postgresql_server_auditing_duration_polices" {
  type        = bool
  description = "Azure Postgresql server auditing duration policies for baseline"
  default     = true
}

variable "azure_postgresql_server_auditing_duration_days_polices" {
  type        = bool
  description = "Azure postgresql server auditing duration policies for baseline"
  default     = true
}

variable "azure_sql_server_threat_protection_types_polices" {
  type        = bool
  description = "Azure Sql server threat protection types policies for baseline"
  default     = true
}

variable "azure_sql_database_threat_protection_types_polices" {
  type        = bool
  description = "Azure Sql database threat protection types policies for baseline"
  default     = true
}

variable "azure_storage_queue_service_logging_polices" {
  type        = bool
  description = "Azure storage queue service logging policies for baseline"
  default     = true
}

variable "azure_storage_queue_service_logging_properties_polices" {
  type        = bool
  description = "Azure storage queue service logging properties policies for baseline"
  default     = true
}

variable "azure_storage_queue_service_logging_properties_retention_days_polices" {
  type        = bool
  description = "Azure storage queue service logging properties retention days policies for baseline"
  default     = true
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Check Logging Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure check logging baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
} 
