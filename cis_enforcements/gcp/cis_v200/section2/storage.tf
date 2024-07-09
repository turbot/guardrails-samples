# GCP > Storage > Bucket > Approved
resource "turbot_policy_setting" "gcp_storage_bucket_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketApproved"
  note     = "GCP CIS v2.0.0 - Control: 2.3"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Storage > Bucket > Approved > Custom
resource "turbot_policy_setting" "gcp_storage_bucket_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-storage#/policy/types/bucketApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 2.3"
  template_input = <<-EOT
  - |
    {
      project {
        turbot {
          id
        }
      }

      item: bucket {
        name: get(path: "name")
      }
    }
  - |
    {
      item: bucket {
        name: get(path: "name")
        retentionPolicy: get(path: "retentionPolicy")
      }

      sinkDetails: resources(filter: "resourceId:{{ $.project.turbot.id }} resourceTypeId:'tmod:@turbot/gcp-logging#/resource/types/sink' resourceTypeLevel:self $.destination:'storage.googleapis.com/{{ $.item.name }}' limit:5000") {
        items {
          name: get(path: "name")
          destination: get(path: "destination")
        }
      }
    }
  EOT
  template = <<-EOT
    {%- if $.sinkDetails.items -%}

      {%- if $.sinkDetails.items.length > 0 and $.item.retentionPolicy and $.item.retentionPolicy.isLocked -%}

        {%- set data = {
            "title": "Retention policy using Bucket Lock",
            "result": "Approved",
            "message": "Recommendation met"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Retention policy using Bucket Lock",
            "result": "Not approved",
            "message": "Recommendation not met"
        } -%}

      {%- endif -%}

    {%- else -%}

      {%- set data = {
          "title": "Retention policy using Bucket Lock",
          "result": "Not approved",
          "message": "Recommendation not met"
      } -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
