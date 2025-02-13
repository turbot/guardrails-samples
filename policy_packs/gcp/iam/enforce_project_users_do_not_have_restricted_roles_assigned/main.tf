resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP IAM Project Users do not have Restricted Roles assigned"
  description = "Ensures that project users do not have Restricted roles assigned. This reduces the risk of over-privileged access and enhances security by enforcing least privilege principles for project users."
  akas        = ["gcp_iam_enforce_project_users_do_not_have_restricted_roles_assigned"]
}
