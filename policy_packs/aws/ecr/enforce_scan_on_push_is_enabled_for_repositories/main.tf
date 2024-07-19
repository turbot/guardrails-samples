resource "turbot_policy_pack" "main" {
  title       = "Enforce Scan On Push Is Enabled for AWS ECR Repositories"
  description = "Enforcing scan on push for repositories helps detect vulnerabilities and security issues in images before they are deployed, reducing the risk of running compromised or insecure containers in your environment."
  akas        = ["aws_ecr_enforce_scan_on_push_is_enabled_for_repositories"]
}
