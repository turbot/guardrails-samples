resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances To Not Have Internet Access Via Subnets"
  description = "Ensures that only designated, secure subnets are used, preventing unauthorized access and reducing the risk of misconfigurations that could expose sensitive data or systems to potential threats."
  akas        = ["aws_ec2_enforce_instances_to_not_have_internet_access_via_subnets"]
}
