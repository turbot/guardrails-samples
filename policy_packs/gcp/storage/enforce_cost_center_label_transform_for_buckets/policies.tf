locals {
  yaml_string = <<-EOT
    cost_center:
      incorrectKeys:
        - /.*cost.*cent.*/gi
      replacementValue: undefined
    EOT
}

# Turbot > File
resource "turbot_file" "gcp_label_transform_rules" {
  parent  = "tmod:@turbot/turbot#/"
  title   = "GCP Label Transform Rules"
  akas    = ["gcp_label_transform_rules"]
  content = jsonencode(yamldecode(local.yaml_string))
}

# GCP > Storage > Bucket > Labels
resource "turbot_policy_setting" "gcp_storage_bucket_labels" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketLabels"
  value    = "Check: Labels are correct"
  # value    = "Enforce: Set labels"
}

# GCP > Storage > Bucket > Labels > Template
resource "turbot_policy_setting" "gcp_bucket_labels_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-storage#/policy/types/bucketLabelsTemplate"
  template_input = <<-EOT
    {
      rules: resource(id:"gcp_label_transform_rules") {
        data
      }
      resource {
        turbot {
          tags
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- set tags_map = $.resource.turbot.tags -%}
    {%- set rules = $.rules.data -%}

    {% for key,value in transformMap(tags_map, rules) -%}
    - "{{key}}": "{{value}}"
    {% endfor -%}

    EOT
}


