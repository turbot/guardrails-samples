resource "turbot_policy_pack" "main" {
  title       = "Azure Compute Enforce Boot Diagnostics Are Enabled for VMs"
  description = "Enforce that Azure Virtual Machine Boot Diagnostics are enabled."
  akas        = ["azure_compute_enforce_boot_diagnostics_are_enabled_for_vms"]
}
