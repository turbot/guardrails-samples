# GCP > Compute Engine > Instance > Approved
resource "turbot_policy_setting" "gcp_computeengine_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Compute Engine > Instance > Approved > Custom
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedCustom"
  template_input = <<-EOT
    {
      instance {
        machineType: get(path: "machineType")
      }
    }
    EOT
  template       = <<-EOT
    {%- set results = [] -%}

    # Unapproved sizes of instance types
    {%- set xlSizes = r/.*-(8|16|30|32|60|64)$/ -%}

    {%- if $.instance.machineType and xlSizes.test($.instance.machineType) -%}

      {%- set data = {
          "title": "Instance Size",
          "result": "Not approved",
          "message": "Instance is too large"
      } -%}

    {%- elif $.instance.machineType and not xlSizes.test($.instance.machineType) -%}

      {%- set data = {
          "title": "Instance Size",
          "result": "Approved",
          "message": "Instance has an approved size"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Instance Size",
          "result": "Skip",
          "message": "No data for instance size yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    # Unapproved family of instance types
    {%- set approvedFamily = r/\/(e2|n2|n1)-.*$/ -%}
    
    {%- if $.instance.machineType and approvedFamily.test($.instance.machineType) -%}

      {%- set data = {
          "title": "Instance Family",
          "result": "Not approved",
          "message": "Instance is not in the approved instance family"
      } -%}

    {%- elif $.instance.machineType and not approvedFamily.test($.instance.machineType) -%}

      {%- set data = {
          "title": "Instance Family",
          "result": "Approved",
          "message": "Instance is in the approved instance family"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Instance Family",
          "result": "Skip",
          "message": "No data for instance family yet"
      } -%}

    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}
