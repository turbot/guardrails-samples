resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Compute Virtual Machines to Not Be Older Than 7 Days"
  description = "Ensure that the systems are continuously updated, reducing the risk of vulnerabilities and ensuring compliance with security policies."
  akas        = ["azure_compute_enforce_vms_to_not_be_older_than_7_days"]
}
