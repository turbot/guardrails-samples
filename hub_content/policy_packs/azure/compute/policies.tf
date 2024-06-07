# Azure > Compute > Virtual Machine > Approved
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Compute > Virtual Machine > Approved > Image
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved_image" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApprovedImage"
  value    = "Approved if Image > Status is Enabled"
}

# Azure > Compute > Image > Trusted Publishers > Custom
resource "turbot_policy_setting" "azure_compute_image_trusted_publisher_custom" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-compute#/policy/types/imageTrustedPublishersCustom"
  # Insert your Trusted Publisher below
  value    = yamlencode(["Canonical", "MicrosoftWindowsServer", "RedHat"])
}