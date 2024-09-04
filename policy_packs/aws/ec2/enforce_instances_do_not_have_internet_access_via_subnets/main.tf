resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Do Not Have Internet Access via Subnets"
  description = "Ensure that instances are isolated from the internet, reducing the risk of unauthorized access and potential data breaches, and enhancing security by restricting outbound traffic to approved and monitored channels."
  akas        = ["aws_ec2_enforce_instances_do_not_have_internet_access_via_subnets"]
}
