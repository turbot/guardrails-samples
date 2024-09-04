# GCP > Storage > Bucket > Labels
resource "turbot_policy_setting" "gcp_storage_bucket_labels" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketLabels"
  value    = "Check: Labels are correct"
  # value    = "Enforce: Set labels"
}

# GCP > Storage > Bucket > Labels > Template
resource "turbot_policy_setting" "gcp_storage_bucket_labels_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-storage#/policy/types/bucketLabelsTemplate"
  template_input = <<-EOT
    {
      resource {
        metadata 
      }
    }
    EOT
  template       = <<-EOT
    {% set tags_plan = {} -%}
    
    {%- if $.resource.metadata.createdBy -%}
    
    	{%- set tags_plan = setAttribute(tags_plan, "creator", $.resource.metadata.createdBy) -%}
    
    {%- endif -%}

    {%- if $.resource.metadata.createTimestamp -%}
    
    	{%- set tags_plan = setAttribute(tags_plan, "creationTime", $.resource.metadata.createTimestamp.split('T')[0]) -%}
    
    {%- endif -%}
     
    {%- if tags_plan | length < 1 -%}
    
    	[]
    
    {%- else -%}
    
    	{{ tags_plan | json }}
    
    {%- endif -%}
  EOT
}
