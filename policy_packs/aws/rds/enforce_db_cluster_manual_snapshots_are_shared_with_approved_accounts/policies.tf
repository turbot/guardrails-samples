# AWS > RDS > DB Cluster Snapshot [Manual] > Approved
resource "turbot_policy_setting" "aws_rds_db_cluster_snapshot_manual_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > RDS > DB Cluster Snapshot [Manual] > Approved > Custom
resource "turbot_policy_setting" "aws_rds_db_cluster_snapshot_manual_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualApprovedCustom"
  template_input = <<-EOT
    {
      approvedAccounts: constant(value: "['123456789012', '098765432109']")
      dbClusterSnapshotManual {
        sharedAccounts: get(path:"DBClusterSnapshotAttributes.AttributeValues")
      }
    }
  EOT
  template       = <<-EOT
    {%- set whitelist = $.approvedAccounts -%}
    {%- set approvalCount = 0 -%}

    {%- if $.dbClusterSnapshotManual.sharedAccounts == null -%}

      {%- set data = {
          "title": "Shared Accounts",
          "result": "Skip",
          "message": "No data for shared accounts yet"
      } -%}

    {%- else -%}

      {%- for sharedAccount in $.dbClusterSnapshotManual.sharedAccounts | sort -%}

        {%- for validAccount in whitelist | sort -%}

          {%- if validAccount == sharedAccount -%}

            {%- set approvalCount = approvalCount + 1 -%}

          {%- endif -%}

        {%- endfor -%}

      {%- endfor -%}

      {%- if approvalCount == $.dbClusterSnapshotManual.sharedAccounts | length -%}

        {%- set data = {
            "title": "Shared Accounts",
            "result": "Approved",
            "message": "Snapshot is shared with approved accounts"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Shared Accounts",
            "result": "Not approved",
            "message": "Snapshot is not shared with approved accounts"
        } -%}

      {%- endif -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
