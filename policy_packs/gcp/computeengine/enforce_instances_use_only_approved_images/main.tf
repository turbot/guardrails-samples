resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances Use Only Approved Images"
  description = "Ensure that all instances adhere to organizational standards, reducing the risk of vulnerabilities."
  akas        = ["gcp_computeengine_enforce_instances_use_only_approved_images"]
}
