# List of trusted accounts for cross account access
# More Info: https://turbot.com/v5/docs/concepts/guardrails/public-access

trusted_accounts  = [
  "{{ $.account.Id }}", # Self - current AWS Account
  "287590803701", # Turbot SaaS US Prod
  "255798382450", # Turbot SaaS EU Account
]

# See file, sqs_trusted_access.tf
enable_aws_sqs_queue_trusted_access = false

# See file, database_public.tf
enable_aws_rds_db_cluster_snapshot_manual_trusted_access = false
enable_aws_rds_db_instance_public = false
enable_aws_rds_db_snapshot_manual_trusted_access = false
enable_aws_redshift_cluster_public = false
enable_aws_redshift_cluster_snapshot_manual_trusted_access = false

# See file, route53.tf
enable_aws_route53_hostedzone_approved = false
enable_aws_route53_hostedzone_approved_usage = false
