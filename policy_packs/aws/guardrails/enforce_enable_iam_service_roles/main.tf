resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable AWS IAM Service Roles"
  description = "Ensure that service roles are properly configured and used, allowing AWS services to interact with your resources securely, minimizing the risk of unauthorized actions."
  akas        = ["aws_iam_enforce_enable_iam_service_roles"]
}
