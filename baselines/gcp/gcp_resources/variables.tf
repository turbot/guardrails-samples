variable "gcp_project_id" {
  description = "Enter the GCP Project Id that you wish to import: Note that you must set your GCP credentials for this account either in your environment variables or default profile:"
  type        = string
}

variable "gcp_region" {
  type = string

  default = <<EOT
  - us-east1
  EOT
}

variable "resource_prefix" {
  type        = string
  description = "Enter the prefix for all the test resources to be created"
  default     = "turbot_dummy_"
}

variable "number_of_resources" {
  type        = number
  description = "Enter the number of GCP test resources to be created for each resource type:"
  default     = 75
}
