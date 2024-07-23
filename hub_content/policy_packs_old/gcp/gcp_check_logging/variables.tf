# Baseline Configuration

variable "enable_kubernetes_engine_region_cluster_logging_policies" {
  type        = bool
  description = "Enable the Kubernetes Engine Region Cluster policies for baseline"
  default     = true
}

variable "enable_instance_binary_log_policies" {
  type        = bool
  description = "Enable the Instatnce Binary Log policies for baseline"
  default     = true
}

variable "enable_network_region_backend_service_logging_policies" {
  type        = bool
  description = "Enable the Network Region Backend Service Logging policies for baseline"
  default     = true
}

variable "enable_network_region_backend_service_logging_sammple_rate_policies" {
  type        = bool
  description = "Enable the Network Region Backend Service Logging Sample Rate policies for baseline"
  default     = true
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Check Logging Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP check logging baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
