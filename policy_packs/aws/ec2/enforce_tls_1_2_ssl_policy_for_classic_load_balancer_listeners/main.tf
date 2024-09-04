resource "turbot_policy_pack" "main" {
  title       = "Enforce TLS 1.2 SSL Policy for AWS EC2 Classic Load Balancer Listeners"
  description = "This measure helps in protecting data in transit by enforcing stronger encryption standards, thereby reducing the risk of data breaches and ensuring compliance."
  akas        = ["aws_ec2_enforce_tls_1_2_ssl_policy_for_classic_load_balancer_listeners"]
}
