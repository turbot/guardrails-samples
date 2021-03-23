# Baseline Configuration

variable "enable_bigquery_dataset_approved_policies" {
  type        = bool
  description = "Enable the Bigquery Dataset approved policies for baseline"
  default     = true
}

variable "enable_bigquery_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Bigquery Resources"
  default     = true
}

variable "enable_computeengine_image_approved_policies" {
  type        = bool
  description = "Enable the Compute Engine Image approved policies for baseline"
  default     = true
}

variable "enable_compute_engine_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Compute Engine Resources"
  default     = true
}

variable "enable_dataflow_job_approved_policies" {
  type        = bool
  description = "Enable the Dataflow Job approved policies for baseline"
  default     = true
}

variable "enable_dataflow_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Dataflow resources"
  default     = true
}

variable "enable_dataproc_cluster_approved_policies" {
  type        = bool
  description = "Enable the Dataproc Cluster approved policies for baseline"
  default     = true
}

variable "enable_dataproc_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Dataproc resources"
  default     = true
}

variable "enable_kubernetesengine_region_cluster_approved_policies" {
  type        = bool
  description = "Enable the Kubernetes Engine Region Cluster approved policies for baseline"
  default     = true
}

variable "enable_kubernetes_engine_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Kubernetes Engine resources"
  default     = true
}

variable "enable_pubsub_topic_approved_policies" {
  type        = bool
  description = "Enable the PubSub Topic approved policies for baseline"
  default     = true
}

variable "enable_pub_sub_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on PubSub resources"
  default     = true
}

variable "enable_storage_encryption_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Storage resources"
  default     = true
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Check Encryption Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP Check Encryption"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
