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

    {# This is because gcePdKmsKeyName property doesn't exist incase of GCP managed key #}
    {%- if encryptionConfig and encryptionConfig.gcePdKmsKeyName -%}

      {%- set data = {
          "title": "Dataproc Cluster encrypted with Customer-Managed key",
          "result": "Approved",
          "message": "Dataproc Cluster is encrypted with Customer-Managed Encryption key"
      } -%}

    {%- elif encryptionConfig and not encryptionConfig.gcePdKmsKeyName -%}

      {%- set data = {
          "title": "Dataproc Cluster encrypted with Customer-Managed key",
          "result": "Not Approved",
          "message": Dataproc Cluster is not encrypted with Customer-Managed Encryption key"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Dataproc Cluster encrypted with Customer-Managed key",
          "result": "Skip",
          "message": "No data for encryption of Dataproc Cluster yet"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
