output "enable_cloudtrail_trail_log_validation" {
  value = var.enable_cloudtrail_trail_log_validation
}

output "enable_cloudtrail_trail_status" {
  value = var.enable_cloudtrail_trail_status
}

output "enable_cloudtrail_trail_encryption" {
  value = var.enable_cloudtrail_trail_encryption
}

output "enable_alb_access_logging" {
  value = var.enable_alb_access_logging
}

output "enable_elb_access_logging" {
  value = var.enable_elb_access_logging
}

output "enable_nlb_access_logging" {
  value = var.enable_elb_access_logging
}

output "enable_redshift_cluster_access_logging" {
  value = var.enable_redshift_cluster_access_logging
}

output "enable_redshift_cluster_user_logging" {
  value = var.enable_redshift_cluster_user_logging
}

output "enable_aws_s3_bucket_access_logging" {
  value = var.enable_aws_s3_bucket_access_logging
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
