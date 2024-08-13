# Smartfolder configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Stack Example Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP Stack baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

# Baseline configuration
variable "gcp_project_pubsub_stack_policies" {
  type        = bool
  description = "Enable the GCP Project PubSub Stack policies for baseline"
  default     = true
}

variable "gcp_project_pubsub_stack_tfversion_policies" {
  type        = bool
  description = "Enable the GCP Project PubSub Stack TFversion policies for baseline"
  default     = true
}

variable "gcp_project_pubsub_stack_source_policies" {
  type        = bool
  description = "Enable the GCP Project PubSub Stack Source policies for baseline"
  default     = true
}
