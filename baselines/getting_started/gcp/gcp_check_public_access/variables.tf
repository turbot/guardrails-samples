# Baseline Configuration

variable "enable_instance_block_project_wide_ssh_keys_policies" {
  type        = bool
  description = "Enable Compute Engine Instance Block Project Wide SSH Keys policies for baseline"
  default     = true
}

variable "enable_instance_external_ip_addresses_policies" {
  type        = bool
  description = "Enable the GCP Compute Engine instance external IP addresses policies for baseline"
  default     = true
}

variable "enable_instance_serial_port_access_policies" {
  type        = bool
  description = "Enable Compute Engine instance Serial Port Access policies for baseline"
  default     = true
}

variable "enable_gcp_network_firewall_ingress_rules_approved_policies" {
  type        = bool
  description = "Enable GCP Network Firewall Ingress Rule approved policies for baseline"
  default     = true
}

variable "enable_gcp_network_firewall_ingress_rules_approved_rules_policies" {
  type        = bool
  description = "Enable GCP Network Firewall Ingress Rule OCL policies for baseline"
  default     = true
}

# Optional Common Baseline Configuration

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