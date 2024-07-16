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
  template_input = <<EOT
    {
      instance {
        machineType
      }
    }
    EOT
  template       = <<EOT
    {% set toobig = r/.*-(8|16|30|32|60|64)$/ -%}
    {% if toobig.test($.instance.machineType) -%}
    - title: Instance Size
      result: Not approved
      message: Instance is too large.
    {%- else -%}
    - title: Instance Size
      result: Approved
      message: Instance is an approved size.
    {%- endif %}

    {% set approved_family = r/\/(e2|n2|n1)-.*$/ -%}
    {% if approved_family.test($.instance.machineType) -%}
    - title: Instance Family
      result: Approved
      message: Instance is in an approved instance family.
    {% else -%}
    - title: Instance Family
      result: Not approved
      message: Instance is not in an approved instance family.
    {%- endif -%}
  EOT
}
