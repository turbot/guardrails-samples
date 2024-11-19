# Create Smart Folder
resource "turbot_policy_pack" "azure_region_support" {
  parent = "tmod:@turbot/turbot#/"
  title  = "Add Azure Region Support for westus3"
}

# Overide Region Availability for Service
resource "turbot_policy_setting" "azure_service_regions_default" {
  for_each       = toset(local.azure_region_policies)
  resource       = turbot_policy_pack.azure_region_support.id
  type           = each.key
  template_input = <<-EOT
    {
      regions: policyValue(uri:"${each.key}") {
        value
      }
    }
    EOT
  template       = <<-EOT
    {%- if "${local.region_to_add}" in $.regions.value -%}
    {{ $.regions.value | json }}
    {%- else -%}
    - "${local.region_to_add}"
    {% for region in $.regions.value -%}
    - "{{ region }}"
    {% endfor -%}
    {%- endif -%}
    EOT
}