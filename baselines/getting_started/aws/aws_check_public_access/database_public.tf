# Check for Instance & Cluster Public Access, and Cross Account DB Snapshot Sharing
# Commented out since these services are not associated to the initial mod install list

# Check public Redshift accessibility
# AWS > Redshift > Cluster > Cluster Publicly Accessible
# https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterPubliclyAccessible
resource "turbot_policy_setting" "aws_redshift_cluster_public" {
  count    = var.enable_aws_redshift_cluster_public ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterPubliclyAccessible"
  value    = "Check: Cluster is not publicly accessible"
}

# Check public RDS DB Instance accessibility
# AWS > RDS > DB Instance > DB Instance Publicly Accessible
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbInstancePubliclyAccessible
resource "turbot_policy_setting" "aws_rds_db_instance_public" {
  count    = var.enable_aws_rds_db_instance_public ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstancePubliclyAccessible"
  value    = "Check: DB Instance is not publicly accessible"
}

# Check public Redshift Snapshot accessibility
# AWS > Redshift > Manual Cluster Snapshot > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-redshift/inspect#/policy/types/clusterSnapshotManualTrustedAccess
resource "turbot_policy_setting" "aws_redshift_cluster_snapshot_manual_trusted_access" {
  count    = var.enable_aws_redshift_cluster_snapshot_manual_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
}

# Check public RDS DB Instance Snapshot accessibility
# AWS > RDS > DB Snapshot [Manual] > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbSnapshotManualTrustedAccess
resource "turbot_policy_setting" "aws_rds_db_snapshot_manual_trusted_access" {
  count    = var.enable_aws_rds_db_snapshot_manual_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
}

# Check public RDS DB Cluster Snapshot accessibility
# AWS > RDS > DB Cluster Snapshot [Manual] > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-rds/inspect#/policy/types/dbClusterSnapshotManualTrustedAccess
resource "turbot_policy_setting" "aws_rds_db_cluster_snapshot_manual_trusted_access" {
  count    = var.enable_aws_rds_db_cluster_snapshot_manual_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
}



## Older Calc policy example for RDS DB Snapshot Public

# Check public RDS DB Snapshot accessibility
# resource "turbot_policy_setting" "aws_rds_snapshot_approved" {
#     resource    = turbot_smart_folder.aws_public_access.id
#     type        = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApproved"
#     value       = "Check: Approved"
# }

# Check public RDS DB Snapshot accessibility usage conditions
# resource "turbot_policy_setting" "aws_rds_snapshot_approved_usage" {
#   resource      = turbot_smart_folder.aws_public_access.id
#   type          = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApprovedUsage"
#   # GraphQL to get metadata
#   template_input  = <<-QUERY
#       {
#           resource {
#               public: get(path: "Public")
#           }
#       }
#       QUERY
#   # Nunjucks template evaluate metadata.
#   template        = <<-TEMPLATE
#       {%- if $.resource.public -%}
#           Not approved
#       {%- else -%}
#           Approved
#       {%- endif -%}
#       TEMPLATE
# }
