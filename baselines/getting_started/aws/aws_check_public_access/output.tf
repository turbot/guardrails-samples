output "trusted_accounts" {
  value = var.trusted_accounts
}

output "enable_aws_redshift_cluster_public" {
  value = var.enable_aws_redshift_cluster_public
}

output "enable_aws_rds_db_instance_public" {
  value = var.enable_aws_rds_db_instance_public
}

output "enable_aws_redshift_cluster_snapshot_manual_trusted_access" {
  value = var.enable_aws_redshift_cluster_snapshot_manual_trusted_access
}

output "enable_aws_rds_db_snapshot_manual_trusted_access" {
  value = var.enable_aws_rds_db_snapshot_manual_trusted_access
}

output "enable_aws_rds_db_cluster_snapshot_manual_trusted_access" {
  value = var.enable_aws_rds_db_cluster_snapshot_manual_trusted_access
}

output "enable_aws_route53_hostedzone_approved" {
  value = var.enable_aws_route53_hostedzone_approved
}

output "enable_aws_route53_hostedzone_approved_usage" {
  value = var.enable_aws_route53_hostedzone_approved_usage
}

output "enable_aws_sqs_queue_trusted_access" {
  value = var.enable_aws_sqs_queue_trusted_access
}

output "enable_aws_trusted_accounts_template" {
  value = var.enable_aws_trusted_accounts_template
}
