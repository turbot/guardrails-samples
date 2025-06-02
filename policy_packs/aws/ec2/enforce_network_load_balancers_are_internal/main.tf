resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Network Load Balancers Are Internal"
  description = "This practice helps improve security by ensuring that Network Load Balancers are not exposed to the internet unless explicitly required, reducing the attack surface and potential security risks."
  akas        = ["aws_ec2_enforce_network_load_balancers_are_internal"]
} 
