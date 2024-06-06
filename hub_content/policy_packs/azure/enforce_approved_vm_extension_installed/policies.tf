# Azure > Compute > Virtual Machine > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
}

# List of Approved VM Extensions.  Taken from the Azure names for these extensions.
# If the extension name isn't in the approved_extensions list, it's unapproved.
resource "turbot_file" "vm_approved_extensions" {
  parent  = "tmod:@turbot/turbot#/"
  title   = "VM Approved Extensions"
  akas    = ["vm_approved_extensions"]
  content = <<EOT
{
  "approved_extensions": [
    "CustomScript"
  ]
}
EOT
}

# Azure > Compute > Virtual Machine > Approved > Custom
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedCustom"
  template_input = <<EOT
{
  virtualMachine {
    name
    extensions: get(path: "resources")
  }
  approved_extensions:resource(id:"vm_approved_extensions")   {
    data
  }
}
EOT
  template       = <<EOT
{% set approved_extensions = $.approved_extensions.data.approved_extensions -%}
{% if $.virtualMachine.extensions %}

  {% for extension in $.virtualMachine.extensions -%}
  {% if extension.name in approved_extensions %}
{% raw %}
- title: {% endraw %}{{ extension.name }}{% raw %} found
  result: Approved
  message: {% endraw %}{{ extension.name }}{% raw %} is approved.{% endraw %}
  {%- else -%}
  {% raw %}
- title: {% endraw %}{{ extension.name }}{% raw %} found
  result: Not approved
  message: {% endraw %}{{ extension.name }}{% raw %} is not approved.{% endraw %}
  {%- endif -%}
{% endfor -%}

{% else %}
result: Approved
{% endif %}
EOT
}
