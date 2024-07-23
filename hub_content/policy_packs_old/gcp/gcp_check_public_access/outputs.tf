# Baseline configuration
output "instance_serial_port_access" {
  value = var.instance_serial_port_access
}

output "gcp_network_firewall_ingress_rules_approved" {
  value = var.gcp_network_firewall_ingress_rules_approved
}

output "gcp_service_trusted_access" {
  value = var.gcp_service_trusted_access
}

output "enable_compute_engine_policies" {
  value = var.enable_compute_engine_policies
}

output "enable_network_policies" {
  value = var.enable_network_policies
}

# Smart folder 

output "turbot_profile" {
  value = var.turbot_profile
}

output "smart_folder_name" {
  value = var.smart_folder_name
}

output "smart_folder_description" {
  value = var.smart_folder_description
}

output "smart_folder_parent_resource" {
  value = var.smart_folder_parent_resource
}
