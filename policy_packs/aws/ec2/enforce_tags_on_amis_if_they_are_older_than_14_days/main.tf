resource "turbot_policy_pack" "main" {
  title       = "Enforce Tags on AMIs if They Are Older Than 14 Days"
  description = "Ensure that aged AMIs are properly identified and classified, facilitating their management, compliance with organizational policies, and aiding in decisions related to their retention or deprecation."
  akas        = ["aws_ec2_enforce_tags_on_amis_if_they_are_older_than_14_days"]
}
