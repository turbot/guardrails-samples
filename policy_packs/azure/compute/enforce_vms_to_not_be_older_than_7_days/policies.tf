# Azure > Compute > Virtual Machine > Active
resource "turbot_policy_setting" "azure_compute_virtual_machine_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/virtualMachineActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# Azure > Compute > Virtual Machine > Active > Age
resource "turbot_policy_setting" "azure_compute_virtual_machine_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/virtualMachineActiveAge"
  value    = "Force inactive if age > 7 days"
}
