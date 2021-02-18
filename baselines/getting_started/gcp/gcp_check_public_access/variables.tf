variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Check Public Access Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for GCP Check Public Access baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

variable "instance_serial_port_access" {
  type        = string
  default = "Check: Enabled"
}

variable "gcp_network_firewall_ingress_rules_approved" {
  type        = string
  default = "Check: Approved"
}

variable "gcp_service_trusted_access" {
  type        = string
  default = "Check: Trusted Access > *"
}