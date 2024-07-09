# Baseline Configuration
variable "appservice_function_app_approved_usage_policies" {
  type        = bool
  description = "Enable the Azure Appservice approved usage policies for baseline"
  default     = true
}

variable "azure_appservice_web_app_approved_usage_policies" {
  type        = bool
  description = "Enable the Azure Appservice Web App approved usage policies for baseline"
  default     = true
}

variable "azure_compute_disk_approved_usage_policies" {
  type        = bool
  description = "Enable the Azure Compute Dosk approved usage policies for baseline"
  default     = true
}

variable "azure_mysql_server_encryption_in_transit_policies" {
  type        = bool
  description = "Enable the Azure MySQL Server encryption in transit policies for baseline"
  default     = true
}

variable "azure_postgresql_server_encryption_in_transit_policies" {
  type        = bool
  description = "Enable the Azure PostgreSQL Server encryption in transit policies for baseline"
  default     = true
}

variable "azure_sql_database_encryption_at_rest_policies" {
  type        = bool
  description = "Enable the Azure SQL Database encryption at rest policies for baseline"
  default     = true
}

variable "azure_storage_storage_account_encryption_in_transit_policies" {
  type        = bool
  description = "Enable the Azure Storage Account encryption in transit policies for baseline"
  default     = true
}

variable "azure_storage_storage_account_approved_usage_policies" {
  type        = bool
  description = "Enable the Azure Storage Account approved usage policies for baseline"
  default     = true
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Check Encryption Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure Check Encryption"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
