# Azure > Compute > Virtual Machines > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_smart_folder.azure_cis_v200_s7_virtual_machine.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  note     = "Azure CIS v2.0.0 - Control: 7.2"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > Compute > Virtual Machines > Approved > Custom
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_custom" {
  resource       = turbot_smart_folder.azure_cis_v200_s7_virtual_machine.id
  type           = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 7.2"
  template_input = <<-EOT
    {
      virtualMachine {
        managedDiskId: get(path: "storageProfile.osDisk.managedDisk.id")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.virtualMachine.managedDiskId == "" or $.virtualMachine.managedDiskId == null -%}
    result: Not approved
    message: "The VM is not using managed disks"
    {%- else -%}
    result: Approved
    message: "The VM is using managed disks"
    {%- endif -%}
    EOT
}
