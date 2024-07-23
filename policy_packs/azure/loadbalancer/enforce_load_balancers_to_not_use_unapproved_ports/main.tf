resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Load Balancer to Not Use Unapproved Ports"
  description = "Ensure that only approved and necessary ports are used, reducing the risk of unauthorized access and potential attacks, and enhancing overall security."
  akas        = ["azure_loadbalancer_enforce_load_balancers_to_not_use_unapproved_ports"]
}
