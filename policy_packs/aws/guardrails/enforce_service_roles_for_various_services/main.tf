resource "turbot_policy_pack" "main" {
  title       = "Enforce Service Role for Various Services"
  description = "Ensuring service roles are assigned to specific services means that each service and application operates with only the permissions it needs to perform its specific tasks, thereby minimizing the risk of unauthorized access and potential security breaches caused by over-permissioned accounts."
  akas        = ["aws_iam_enforce_service_roles_for_various_services"]
}
