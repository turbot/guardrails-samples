resource "turbot_policy_pack" "main" {
  title       = "Azure Compute Enforce Diagnostic Logs Are Enabled for VMs"
  description = "Enforce that Azure Virtual Machine Diagnostic logs are enabled."
  akas        = ["azure_compute_enforce_diagnostic_logs_are_enabled_for_vms"]
}
