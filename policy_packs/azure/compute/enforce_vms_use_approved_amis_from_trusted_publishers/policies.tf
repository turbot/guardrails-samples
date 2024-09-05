# Azure > Compute > Virtual Machine > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Compute > Virtual Machine > Approved > Image
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImage"
  value    = "Approved if Image > Status is Enabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > Rules
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageRules"
  template_input = <<-EOT
    {
      approvedImages: constant(value: "['imageId1', 'imageId2', 'imageId3', 'imageId4']")
    }
    EOT
  template       = <<-EOT
    {% for image in $.approvedImages -%}
      ENABLED "{{ image }}"
    {%- endfor %}
    EOT
}

# Azure > Compute > Virtual Machine > Approved > Image > Ubuntu 18.04
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_ubuntu18" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageUbuntu18"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > Windows 2012-R2 Datacenter
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_windows2012_data_center" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageWindows2012DataCenter"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > Ubuntu 16.04
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_ubuntu16" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageUbuntu16"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > Windows 2019 Datacenter
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_windows2019_data_center" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageWindows2019DataCenter"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > Windows 2016 Datacenter
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_windows2016_data_center" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageWindows2016DataCenter"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > RHEL 7
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_rhel7" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageRHEL7"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > RHEL 6
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_rhel6" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageRHEL6"
  value    = "Disabled"
}

# Azure > Compute > Virtual Machine > Approved > Image > Local
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image_local" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImageLocal"
  value    = "Enabled"
}
