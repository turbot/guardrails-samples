# GCP > Dataproc > Cluster > Approved
resource "turbot_policy_setting" "gcp_dataproc_cluster_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApproved"
  note     = "GCP CIS v2.0.0 - Control: 1.17"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Dataproc > Cluster > Approved > Custom
resource "turbot_policy_setting" "gcp_dataproc_cluster_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 1.17"
  template_input = <<-EOT
    {
      item: cluster {
        encryptionConfig: get(path: "config.encryptionConfig")
      }
    }
  EOT
  template       = <<-EOT
    {% set encryptionConfig = $.item.encryptionConfig %}

    {# Check gcePdKmsKeyName property because it doesn't exist incase of GCP managed key #}
    {%- if encryptionConfig and encryptionConfig.gcePdKmsKeyName -%}

      {%- set data = {
          "title": "Encryption with customer managed key",
          "result": "Approved",
          "message": "Cluster is encrypted with customer managed key"
      } -%}

    {%- elif encryptionConfig and not encryptionConfig.gcePdKmsKeyName -%}

      {%- set data = {
          "title": "Encryption with customer managed key",
          "result": "Not Approved",
          "message": "Cluster is not encrypted with customer managed key"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Encryption with customer managed key",
          "result": "Skip",
          "message": "No data for encryption yet"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
