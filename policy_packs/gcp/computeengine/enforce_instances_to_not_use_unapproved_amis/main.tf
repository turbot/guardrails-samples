resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances to Not Use Unapproved Images"
  description = "Prevent the use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed in GCP Compute Engine."
  akas        = ["gcp_computeengine_enforce_instances_to_not_use_unapproved_amis"]
}
