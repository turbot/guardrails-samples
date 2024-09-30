# Azure > Compute > VM Scale Set > Tags
resource "turbot_policy_setting" "azure_compute_virtual_machine_scale_set_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineScaleSetTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# Azure > Compute > VM Scale Set > Tags > Template
resource "turbot_policy_setting" "azure_compute_virtual_machine_scale_set_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-compute#/policy/types/virtualMachineScaleSetTagsTemplate"
  template_input = <<-EOT
    { 
      resource {
        turbot {
          tags
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- set cleanTags = [ "Cost_Center" ] -%}
    {%- set tag_map = {} -%}
    {%- if $.resource.turbot.tags -%}
      {%- for clean_tag_key in cleanTags -%}
        {%- set found_tag = false -%}
        {%- for curr_tag_key, curr_tag_value in $.resource.turbot.tags -%}
          {%- if ((curr_tag_key | lower) == (clean_tag_key | lower)) -%}
            {%- set found_tag = true -%}
            {%- if curr_tag_key != clean_tag_key -%}
              {%- set tag_map = setAttribute(tag_map, curr_tag_key, null) -%}
            {%- endif -%}
          {%- endif -%}
        {%- endfor -%}
        {%- if not found_tag -%}
          {%- set tag_map = setAttribute(tag_map, clean_tag_key, "abc123") -%}
        {%- endif -%}
      {%- endfor -%}
    {%- endif -%}
    {%- if tag_map | length < 1 -%}
    []
    {%- else -%}
    {{ tag_map | json }}
    {%- endif -%}
    EOT
}