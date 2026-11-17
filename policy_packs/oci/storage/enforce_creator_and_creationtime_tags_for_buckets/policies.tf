# OCI > Storage > Bucket > Freeform Tags
resource "turbot_policy_setting" "oci_storage_bucket_freeform_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-storage#/policy/types/bucketFreeformTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# OCI > Storage > Bucket > Freeform Tags > Template
resource "turbot_policy_setting" "oci_storage_bucket_freeform_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/oci-storage#/policy/types/bucketFreeformTagsTemplate"
  template_input = <<-EOT
    {
      bucket {
        createdBy: get(path: "createdBy")
        definedTags: get(path: "definedTags")
        timeCreated: get(path: "timeCreated")
      }
    }
    EOT
  template       = <<-EOT
    {%- set creator = "" -%}
    {%- set creationTime = "" -%}

    {%- if $.bucket.definedTags and $.bucket.definedTags["Oracle-Tags"] and $.bucket.definedTags["Oracle-Tags"].CreatedBy -%}
      {%- set creator = $.bucket.definedTags["Oracle-Tags"].CreatedBy -%}
    {%- elif $.bucket.createdBy -%}
      {%- set creator = $.bucket.createdBy -%}
    {%- endif -%}

    {%- if $.bucket.timeCreated -%}
      {%- set creationTime = $.bucket.timeCreated.split("T")[0] -%}
    {%- endif -%}

    {%- if creator and creationTime -%}
      {{ {"creator": creator, "creationTime": creationTime} | json }}
    {%- elif creator -%}
      {{ {"creator": creator} | json }}
    {%- elif creationTime -%}
      {{ {"creationTime": creationTime} | json }}
    {%- else -%}
      []
    {%- endif -%}
    EOT
}
