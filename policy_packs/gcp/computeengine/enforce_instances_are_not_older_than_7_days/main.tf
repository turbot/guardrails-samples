resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Compute Engine Instances Are Not Older Than 7 Days"
  description = "Enforcing instances to not be older than 7 days is important to ensure that instances are regularly updated and patched, minimizing the risk of vulnerabilities and security exploits."
  akas        = ["gcp_computeengine_enforce_instances_are_not_older_than_7_days"]
}
