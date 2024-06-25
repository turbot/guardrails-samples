resource "turbot_smart_folder" "pack" {
  title       = "Enforce Approved Extensions Are Installed on Azure Compute Virtual Machines"
  description = "Ensures that all installed extensions have been vetted for security and compliance, reducing the risk of vulnerabilities, unauthorized access, and ensuring adherence to organizational policies."
  parent      = "tmod:@turbot/turbot#/"
}
