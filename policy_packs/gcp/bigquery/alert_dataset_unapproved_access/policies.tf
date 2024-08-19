# GCP > BigQuery > DataSet > Approved
resource "turbot_policy_setting" "gcp_bigquery_dataset_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-bigquery#/policy/types/datasetApproved"
  value    = "Check: Approved"
  note     = "Should never be set to Enforce, as Guardrails will attempt to destroy the dataset if unapproved access has been granted. "
}

# GCP > BigQuery > DataSet > Approved > Custom
resource "turbot_policy_setting" "gcp_bigquery_dataset_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-bigquery#/policy/types/datasetApprovedCustom"
  template_input = <<-EOT
    {
      dataset {
        access: get(path: "access")
      }
    }
  EOT

  template       = <<-EOT
    {% set forbidden_regex = r/(?=.*dev-)(?=.*dtap)/g -%}
    {% set unapproved_found = false -%}
    {% for grant in $.dataset.access -%}
    {% if forbidden_regex.test(grant.userByEmail) or forbidden_regex.test(grant.groupByEmail)  -%}
    - title: Unapproved Access
      result: Not approved
      message: Unapproved access was found for {% if grant.userByEmail %}{{ grant.userByEmail }}{% else %}{{ grant.groupByEmail }}{% endif %} with role of {{ grant.role }}.
      {% set unapproved_found = true -%}
    {% endif %}
    {% endfor -%}
    {% if not unapproved_found -%}
    - title: Unapproved Access
      result: Approved
      message: No unapproved access was found.
    {% endif -%}
  EOT
}


