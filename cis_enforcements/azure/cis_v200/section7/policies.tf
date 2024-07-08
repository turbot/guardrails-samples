# Azure > Compute > Virtual Machines > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  note     = "Azure CIS v2.0.0 - Control: 7.2, 7.5 and 7.6"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Compute > Virtual Machines > Approved > Custom
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_custom" {
  resource       = turbot_smart_folder.main.id
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
          "title": "Managed Disk",
          "result": "Not approved",
          "message": $.virtualMachine.name + " is not using managed disks"
      } -%}

    {%- elif $.virtualMachine.managedDiskId -%}

      {%- set data = {
          "title": "Managed Disk",
          "result": "Approved",
          "message": $.virtualMachine.name + " is using managed disks"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Managed Disk",
          "result": "Skip",
          "message": "No data for managed disks yet"
      } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

    {%- if $.virtualMachine.extensions -%}

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

      {%- set data = {
          "title": "Extensions",
          "result": "Skip",
          "message": "No data for extensions yet"
      } -%}

    {% endif -%}

    {% set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}

# Azure > Compute > Disk > Encryption At Rest
resource "turbot_policy_setting" "azure_compute_disk_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionAtRest"
  note     = "Azure CIS v2.0.0 - Control: 7.3, 7.4 and 7.7"
  value    = "Check: Encryption at Rest > Disk Encryption Set"
  # value    = "Enforce: Encryption at Rest > Disk Encryption Set"
}

# Azure > Compute > Disk > Encryption At Rest > Disk Encryption Set
resource "turbot_policy_setting" "azure_compute_disk_encryption_at_rest_disk_encryption_set" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionAtRestDiskEncryptionSet"
  note     = "Azure CIS v2.0.0 - Control: 7.3, 7.4 and 7.7"
  # "Disk Encryption Set ID to be used for Encryption at Rest"
  value = "/subscriptions/cd1234c5-6cc7-8901-a234-567c8e901f2e/resourceGroups/myResourceGroup/providers/Microsoft.Compute/diskEncryptionSets/myDiskEncryptionSet"
}
