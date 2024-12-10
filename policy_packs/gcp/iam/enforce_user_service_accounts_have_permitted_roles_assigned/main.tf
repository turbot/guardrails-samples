resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM Service Accounts have Permitted Roles assigned"
  description = "Ensures that service accounts do not have disallowed roles assigned. This reduces the risk of over-privileged access and enhances security by enforcing least privilege principles for service accounts."
  akas        = ["gcp_iam_enforce_service_accounts_have_permitted_roles_assigned"]
}
