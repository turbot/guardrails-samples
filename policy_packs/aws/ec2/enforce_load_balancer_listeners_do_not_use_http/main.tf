resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Load Balancer Listeners Do Not Use HTTP"
  description = "This practice helps improve security by ensuring that Load Balancer listeners do not use HTTP protocol."
  akas        = ["aws_ec2_enforce_load_balancer_listeners_do_not_use_http"]
}
