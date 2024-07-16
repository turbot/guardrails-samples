resource "turbot_policy_pack" "main" {
  title       = "Enforce TLS 1.2 or Greater SSL Policy for Classic Load Balancer Listener"
  description = "Ensure that AWS EC2 Classic Load Balancer listeners use SSL policies with TLS 1.2 or greater for any traffic traveling outside of the VPC."
  akas        = ["aws_ec2_enforce_tls_1_2_or_greater_ssl_policy_for_classic_load_balancer_listener"]
}
