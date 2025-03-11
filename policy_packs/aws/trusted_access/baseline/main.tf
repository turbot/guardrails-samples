resource "turbot_policy_pack" "main" {
  title       = "Baseline for AWS Trusted Access Exception Management"
  description = "Establishes baseline policies for managing exceptions to trusted access controls in AWS services, ensuring proper governance when deviating from standard security configurations."
  akas        = ["aws_trusted_access_exception_baseline"]
}