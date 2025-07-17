output "policy_pack_id" {
  description = "The ID of the created policy pack"
  value       = turbot_policy_pack.main.id
}

output "policy_pack_title" {
  description = "The title of the created policy pack"
  value       = turbot_policy_pack.main.title
}

output "time_limited_exceptions_enabled" {
  description = "Whether time-limited exceptions are enabled"
  value       = var.enable_time_limited_exceptions
}

output "exception_duration_hours" {
  description = "Duration in hours for the security group exceptions"
  value       = var.exception_duration_hours
}

output "exception_expiry_time" {
  description = "When the exceptions will expire (if enabled)"
  value       = var.enable_time_limited_exceptions ? timeadd(timestamp(), "${var.exception_duration_hours}h") : "N/A - Time limits disabled"
}

output "affected_ports" {
  description = "Ports that will have time-limited access"
  value       = ["22 (SSH)", "3389 (RDP)"]
}
