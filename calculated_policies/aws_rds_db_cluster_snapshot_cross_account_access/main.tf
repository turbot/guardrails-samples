resource "turbot_smart_folder" "rds_smart_folder" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

resource "turbot_policy_setting" "rds_approved_usage_policy_setting" {
  resource       = turbot_smart_folder.rds_smart_folder.id
  type           = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApprovedUsage"
  template_input = <<EOF
  {
    dbClusterSnapshotManual 
    {
      sharedAccounts: get(path:"DBClusterSnapshotAttributes.AttributeValues")
    }
  }
  EOF
  template       = <<EOF
  {#- Whitelist of account that are approved for snapshot usage -#}
  {#- To add an item to the whitelist, add an entry to the whitelist array -#}
  {#- set whitelist = ["1111111111111", "2222222222222"] -#}
  {#- Initially the whitelist is set to empty -#}
  {%- set whitelist = [] -%}
  {%- set approvalResult = "Not approved" -%}

  {%- for validAccount in whitelist | sort -%}
    {%- for sharedAccount in $.dbClusterSnapshotManual.sharedAccounts | sort -%}
      {%- if validAccount == sharedAccount -%}
        {%- set approvalResult = "Approved" -%}
      {%- endif -%}
    {%- endfor -%}
  {% else %}
    {%- set approvalResult = "Approved" -%}
  {%- endfor -%}

  "{{ approvalResult }}"
  EOF
  precedence     = "REQUIRED"
}

resource "turbot_smart_folder_attachment" "rds_smart_folder_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.rds_smart_folder.id
}
