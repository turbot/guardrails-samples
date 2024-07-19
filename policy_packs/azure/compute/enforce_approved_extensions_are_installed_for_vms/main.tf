resource "turbot_policy_pack" "main" {
  title       = "Enforce Approved Extensions Are Installed on Azure Compute Virtual Machines"
  description = "Ensures that all installed extensions have been vetted for security and compliance, reducing the risk of vulnerabilities, unauthorized access, and ensuring adherence to organizational policies."
  akas        = ["azure_compute_enforce_approved_extensions_are_installed_for_vms"]
}
