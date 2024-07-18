resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances to not use Unapproved Images"
  description = "Ensure that all instances adhere to organizational standards, reducing the risk of vulnerabilities."
  akas        = ["gcp_computeengine_enforce_instances_to_not_use_unapproved_images"]
}
