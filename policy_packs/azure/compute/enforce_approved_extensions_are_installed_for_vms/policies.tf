# Azure > Compute > Virtual Machine > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Compute > Virtual Machine > Approved > Custom
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedCustom"
  template_input = <<-EOT
    {
      approvedExtensions: constant(value: "['extension1', 'extension2']")
      virtualMachine {
        name
        extensions: get(path: "resources")
      }
    }
  EOT
  template       = <<-EOT
    {% set results = [] -%}

    {%- if $.virtualMachine.extensions -%}

      {%- for extension in $.virtualMachine.extensions -%}

        {%- if extension.name in $.approvedExtensions -%}

          {% set data = {
              "title": extension.name,
              "result": "Approved",
              "message": extension.name + " is approved"
          } -%}

        {%- else -%}

          {% set data = {
              "title": extension.name,
              "result": "Not approved",
              "message": extension.name + " is not approved"
          } -%}

        {%- endif -%}

        {% set results = results.concat(data) -%}

      {% endfor -%}

    {%- else -%}

      {%- set results = {
          "title": "Extensions",
          "result": "Skip",
          "message": "No data for VM yet"
      } -%}

    {% endif -%}
    {{ results | json }}
  EOT
}
