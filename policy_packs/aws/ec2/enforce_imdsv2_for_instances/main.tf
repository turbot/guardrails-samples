resource "turbot_policy_pack" "main" {
  title       = "Enforce IMDSv2 for AWS EC2 Instances"
  description = "Mitigate the risk of unauthorized metadata exposure through vulnerabilities like Server-Side Request Forgery (SSRF)."
  akas        = ["aws_ec2_enforce_imdsv2_for_instances"]
}
