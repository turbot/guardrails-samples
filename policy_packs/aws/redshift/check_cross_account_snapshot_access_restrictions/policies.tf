# AWS > Redshift > Manual Cluster Snapshot > Approved
resource "turbot_policy_setting" "aws_redshift_manual_cluster_snapshot_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > Redshift > Manual Cluster Snapshot > Approved > Custom
resource "turbot_policy_setting" "aws_redshift_manual_cluster_snapshot_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualApprovedCustom"
  template_input = <<-EOT
  {
    clusterSnapshotManual {
      AccountsWithRestoreAccess
    }
  }
  EOT
  template       = <<-EOT
    {% if $.clusterSnapshotManual.AccountsWithRestoreAccess | length -%}

      "Not approved"

    {% else -%}

      "Approved"

    {% endif -%}
  EOT
}
