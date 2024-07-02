# Azure > Compute > Virtual Machines > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_smart_folder.azure_cis_v200_s7_virtual_machine.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  note     = "Azure CIS v2.0.0 - Control: 7.2, 7.5 and 7.6"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Compute > Virtual Machines > Approved > Custom
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_custom" {
  resource       = turbot_smart_folder.azure_cis_v200_s7_virtual_machine.id
  type           = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 7.2, 7.5 and 7.6"
  template_input = <<-EOT
    {
      approvedExtensions: constant(value: "['MDE.Linux', 'extension2']")
      virtualMachine {
        name
        extensions: get(path: "resources")
        managedDiskId: get(path: "storageProfile.osDisk.managedDisk.id")
      }
    }
    EOT
  template       = <<-EOT
    {% set results = [] -%}

    {%- if $.virtualMachine.managedDiskId == "" or $.virtualMachine.managedDiskId == null -%}

      {%- set data = {
          "title": extension.name,
          "result": "Not approved",
          "message": extension.name + " is not using managed disks"
      } -%}

    {%- elif $.virtualMachine.extensions -%}

      {%- for extension in $.virtualMachine.extensions -%}

        {%- if extension.name in $.approvedExtensions -%}

          {% set data = {
              "title": extension.name,
              "result": "Approved",
              "message": extension.name + " is installed"
          } -%}

        {%- else -%}

          {% set data = {
              "title": extension.name,
              "result": "Not approved",
              "message": extension.name + " is not installed"
          } -%}

        {%- endif -%}

        {% set results = results.concat(data) -%}

      {% endfor -%}

    {%- else -%}

      {%- if $.virtualMachine.managedDiskId != "" and $.virtualMachine.managedDiskId != null -%}

        {%- set results = {
            "title": extension.name,
            "result": "Approved",
            "message": extension.name + " is using managed disks"
        } -%}

      {%- else -%}

        {%- set results = {
            "title": "Extensions",
            "result": "Skip",
            "message": "No data for VM yet"
        } -%}

      {%- endif -%}

    {% endif -%}
    {{ results | json }}
  EOT
}
