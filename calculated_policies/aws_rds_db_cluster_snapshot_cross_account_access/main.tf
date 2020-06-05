# Smart Folder Definition
resource "turbot_smart_folder" "rds_smart_folder" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > RDS > DB Cluster Snapshot [Manual] > Approved
resource "turbot_policy_setting" "rds_approved_policy_setting" {
  resource = turbot_smart_folder.rds_smart_folder.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualApproved"
  value    = "Check: Approved"
}

# AWS > RDS > DB Cluster Snapshot [Manual] > Approved > Usage
resource "turbot_policy_setting" "rds_approved_usage_policy_setting" {
  resource       = turbot_smart_folder.rds_smart_folder.id
  type           = "tmod:@turbot/aws-rds#/policy/types/dbClusterSnapshotManualApprovedUsage"
  template_input = <<EOF
  {
    dbClusterSnapshotManual {
      sharedAccounts: get(path:"DBClusterSnapshotAttributes.AttributeValues")
    }
  }
  EOF
  template       = <<EOF
  {#- Whitelist of account that are approved for snapshot usage -#}
  {%- set whitelist = ["${join("\" ,\"", var.approved_accounts)}"] -%}
  {%- set approvalCount = 0 -%}

  {%- for sharedAccount in $.dbClusterSnapshotManual.sharedAccounts | sort -%}
    {%- for validAccount in whitelist | sort -%}
      {%- if validAccount == sharedAccount -%}
        {%- set approvalCount = approvalCount + 1 -%}
      {%- endif -%}
    {%- endfor -%}
  {%- endfor -%}

  {%- if approvalCount ==  $.dbClusterSnapshotManual.sharedAccounts | length -%}
    "Approved"
  {%- else -%}
    "Not approved"
  {%- endif -%}
  EOF
  precedence     = "REQUIRED"
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "rds_smart_folder_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.rds_smart_folder.id
}
