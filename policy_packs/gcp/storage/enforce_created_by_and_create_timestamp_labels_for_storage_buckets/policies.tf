# GCP > Storage > Bucket > Labels
resource "turbot_policy_setting" "gcp_storage_bucket_labels" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketLabels"
  value    = "Check: Labels are correct"
  # value    = "Enforce: Set labels"
}

# GCP > Storage > Bucket > Labels > Template
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedCustom"
  template_input = <<-EOT
    {
      resource {metadata }
      user_department: resource(id:"user_departments_lookup") {data}
    }
    EOT
  template       = <<EOT
    {% set tags_plan = {} -%}
    {# As createdBy and createTimestamp can be null, it's important to test that they are available. -#}
    {% if $.resource.metadata.createdBy -%}
    {% set tags_plan = setAttribute(tags_plan, "creator", $.resource.metadata.createdBy) -%}
    {% endif -%}

    {% if $.resource.metadata.createdBy and $.user_department.data[$.resource.metadata.createdBy] -%}
    {% set tags_plan = setAttribute(tags_plan, "department", $.user_department.data[$.resource.metadata.createdBy] | lower) -%}
    {% endif -%}

    {# Guardrails has this information but some conversion is required to convert the standard ISO date-time to GCP label standards.
    {% if $.resource.metadata.createTimestamp -%}
    {% set tags_plan = setAttribute(tags_plan, "createtimestamp", $.resource.metadata.createTimestamp) -%}
    {% endif -%}
    -#}

    {% if tags_plan | length < 1 -%}
    []
    {% else -%}
    {% for key,value in tags_plan -%}
    - "{{key}}": "{{value}}"
    {% endfor -%}
    {% endif -%}
  EOT
}
