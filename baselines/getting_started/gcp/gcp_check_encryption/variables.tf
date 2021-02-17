# Baseline Configuration

variable "enable_bigquery_dataset_approved_policies" {
  type        = bool
  description = "Enable the Bigquery Dataset approved policies for baseline"
  default     = true
}

variable "enable_bigquery_dataset_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Bigquery Dataset Resources, by default this is disabled"
  default     = true
}

variable "enable_bigquery_table_approved_policies" {
  type        = bool
  description = "Enable the Bigquery Table approved policies for baseline"
  default     = true
}

variable "enable_bigquery_table_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Bigquery Table Resources, by default this is disabled"
  default     = true
}

variable "enable_computeengine_image_approved_policies" {
  type        = bool
  description = "Enable the Compute Engine Image approved policies for baseline"
  default     = true
}

variable "enable_computeengine_image_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Compute Engine Image Resources, by default this is disabled"
  default     = true
}

variable "enable_dataflow_job_approved_policies" {
  type        = bool
  description = "Enable the Dataflow Job approved policies for baseline"
  default     = true
}

variable "enable_dataflow_job_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Dataflow Job Resources, by default this is disabled"
  default     = true
}

variable "enable_dataproc_cluster_approved_policies" {
  type        = bool
  description = "Enable the Dataproc Cluster approved policies for baseline"
  default     = true
}

variable "enable_dataproc_cluster_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Dataproc Cluster resources, by default this is disabled"
  default     = true
}

variable "enable_kubernetesengine_region_cluster_approved_policies" {
  type        = bool
  description = "Enable the Kubernetes Engine Region Cluster approved policies for baseline"
  default     = true
}

variable "enable_kubernetesengine_region_cluster_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Kubernetes Engine Region Cluster resources, by default this is disabled"
  default     = true
}

variable "enable_kubernetesengine_zone_cluster_approved_policies" {
  type        = bool
  description = "Enable the Kubernetes Engine Zone Cluster approved policies for baseline"
  default     = true
}

variable "enable_kubernetesengine_zone_cluster_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Kubernetes Engine Zone Cluster resources, by default this is disabled"
  default     = true
}

variable "enable_pubsub_topic_approved_policies" {
  type        = bool
  description = "Enable the PubSub Topic approved policies for baseline"
  default     = true
}

variable "enable_pubsub_topic_approved_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on PubSub Topic resources, by default this is disabled"
  default     = true
}

variable "enable_storage_bucket_encryption_at_rest_policies" {
  type        = bool
  description = "Enabling will ensure encryption on Storage Bucket resources, by default this is disabled"
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
