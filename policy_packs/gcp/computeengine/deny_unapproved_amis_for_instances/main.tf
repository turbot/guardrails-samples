resource "turbot_policy_pack" "main" {
  title       = "Deny GCP Compute Engine Instances with Unapproved Images"
  description = "Prevent the use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed in GCP Compute Engine."
  akas        = ["gcp_computeengine_deny_unapproved_amis_for_instances"]
}
