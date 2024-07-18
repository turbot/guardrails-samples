resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Load Balancer to not use Unapproved Network Configuration"
  description = "Ensure that only trusted and authorized networks can access the database, reducing the risk of unauthorized access, data breaches, and ensuring compliance."
  akas        = ["azure_loadbalancer_enforce_load_balancer_to_not_use_unapproved_network_configuration"]
}
