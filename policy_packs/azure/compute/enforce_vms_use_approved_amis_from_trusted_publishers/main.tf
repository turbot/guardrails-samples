resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Compute Virtual Machines Use Approved AMIs From Trusted Publishers"
  description = "Ensure that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards."
  akas        = ["azure_compute_enforce_vms_use_approved_amis_from_trusted_publishers"]
}
