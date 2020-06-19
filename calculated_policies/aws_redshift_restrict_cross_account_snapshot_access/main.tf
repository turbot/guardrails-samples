# Smart Folder Definition
resource "turbot_smart_folder" "redshift_smart_folder" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Redshift > Manual Cluster Snapshot > Approved
resource "turbot_policy_setting" "redshift_approved_policy_setting" {
  resource = turbot_smart_folder.redshift_smart_folder.id
  type     = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualApproved"
  value    = "Check: Approved"
}

# AWS > Redshift > Manual Cluster Snapshot > Approved > Usage
resource "turbot_policy_setting" "redshift_approved_usage_policy_setting" {
  resource       = turbot_smart_folder.redshift_smart_folder.id
  type           = "tmod:@turbot/aws-redshift#/policy/types/clusterSnapshotManualApprovedUsage"
  template_input = <<EOF
  {
    clusterSnapshotManual {
      AccountsWithRestoreAccess
    }
  }
  EOF
  template       = <<EOF
  {% if $.clusterSnapshotManual.AccountsWithRestoreAccess | length -%}
    "Not approved"
  {% else -%}
    "Approved"
  {% endif -%}
  EOF
  precedence     = "REQUIRED"
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "redshift_smart_folder_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.redshift_smart_folder.id
}
