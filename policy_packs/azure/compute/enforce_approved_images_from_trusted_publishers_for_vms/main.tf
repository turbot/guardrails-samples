resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Compute Virtual Machines to Use Approved AMIs From Trusted Publishers"
  description = "Ensure that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards."
  parent      = "tmod:@turbot/turbot#/"
}
