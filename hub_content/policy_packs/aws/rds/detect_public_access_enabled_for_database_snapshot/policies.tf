# AWS > RDS > DB Snapshot [Manual] > Approved
resource "turbot_policy_setting" "aws_rds_db_snapshot_manual_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > RDS > DB Snapshot [Manual] > Approved > Custom
resource "turbot_policy_setting" "aws_rds_db_snapshot_manual_approved_custom" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApprovedCustom"
  template_input = <<-EOT
    {
      dbSnapshotManual {
        dbSnapshotAttributes: get(path:"DBSnapshotAttributes")
      }
    }
    EOT
  template       = <<-EOT
    {% for attribute in $.dbSnapshotManual.dbSnapshotAttributes %}
      {% if 'restore' in attribute and attribute.restore[0] == 'all' %}
      result: Not approved
      message: "Database Snapshot is publicly accessible"
      {% else -%}
      result: Approved
      message: "Database Snapshot is not publicly accessible"  
      {% endif %}
    {% endfor %}
    EOT
}