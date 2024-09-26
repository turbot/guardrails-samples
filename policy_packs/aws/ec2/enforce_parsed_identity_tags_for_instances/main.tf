resource "turbot_policy_pack" "main" {
  title       = "Enforce Creator and Creation Time Tags for AWS EC2 Instances"
  description = "Enforcing the use of Creator and Creation Time tags provides critical metadata that helps in identifying the origin and creation time of EC2 Instances."
  akas        = ["aws_ec2_enforce_creator_and_creationtime_tags_for_instances"]
}
