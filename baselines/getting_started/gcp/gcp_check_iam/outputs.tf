# Baseline configuration

output "enable_service_account_key_active_policies" {
  value = var.enable_service_account_key_active_policies
}

output "enable_service_account_key_active_age_policies" {
  value = var.enable_service_account_key_active_age_policies
}

output "service_account_key_approved_policies" {
  value = var.service_account_key_approved_policies
}

output "service_account_key_approved_usage_policies" {
  value = var.service_account_key_approved_usage_policies
}

output "enable_service_account_policy_trusted_access_policies" {
  value = var.enable_service_account_policy_trusted_access_policies
}

output "enable_service_account_policy_trusted_domains_policies" {
  value = var.enable_service_account_policy_trusted_domains_policies
}

# Turbot profile and smart folder

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
