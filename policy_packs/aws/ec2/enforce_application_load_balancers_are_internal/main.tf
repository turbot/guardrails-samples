resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS Application Load Balancers Are Internal"
  description = "This practice helps improve security by ensuring that application load balancers are not exposed to the internet unless explicitly required, reducing the attack surface and potential security risks."
  akas        = ["aws_ec2_enforce_application_load_balancers_are_internal"]
} 
