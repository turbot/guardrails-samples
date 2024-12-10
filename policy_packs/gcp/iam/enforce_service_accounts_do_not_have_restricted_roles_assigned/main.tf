resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM Service Accounts do not have Restricted Roles assigned"
  description = "Ensures that service accounts do not have Restricted roles assigned. This reduces the risk of over-privileged access and enhances security by enforcing least privilege principles for service accounts."
  akas        = ["gcp_iam_enforce_service_accounts_do_not_have_restricted_roles_assigned"]
}
