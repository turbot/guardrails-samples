resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Application Load Balancer Listeners Use HTTPS"
  description = "This practice helps improve security by ensuring that Application Load Balancer listeners use HTTPS protocol instead of HTTP, providing encryption in transit and protecting data from interception."
  akas        = ["aws_ec2_enforce_application_load_balancer_listeners_use_https"]
}
