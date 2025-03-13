resource "turbot_policy_pack" "main" {
  title       = "AWS EC2 Enforce Instances Have Response Hop Limit of 1"
  description = "Enforce that AWS EC2 instances have a response hop limit of 1 for improved security."
  akas        = ["aws_ec2_enforce_ec2_instances_have_response_hop_limit_of_1"]
}
