resource "turbot_policy_pack" "main" {
  title       = "Enforce Tag on Alarm Control for AWS EC2 AMIs Older Than 14 Days"
  description = "Ensures that outdated images are tracked and managed properly, reducing the risk of security vulnerabilities and optimizing cost by avoiding unnecessary storage of obsolete AMIs."
  akas        = ["aws_ec2_enforce_tag_on_alarm_control_for_amis_older_than_14_days"]
}
