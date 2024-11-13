resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Instances Use Root Volumes That Are Encrypted At Rest"
  description = "By ensuring that root volumes are encrypted, you add a layer of security that safeguards data stored on instances, reducing the risk of data breaches in case of unauthorized access to the physical storage or backups."
  akas        = ["aws_ec2_enforce_instances_use_root_volumes_that_are_encrypted_at_rest"]
}
