# Baseline Configuration

variable "service_status" {
  description = "Choose the subset of services that should be configured. Possible values for each service are: [\"Enabled\", \"Disabled\"]"
  type        = map(any)
}

variable "use_event_polling" {
  description = "GCP events will be retrieved by polling set to true or using an event handler if set to false."
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
  default     = "GCP Check Baseline Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

