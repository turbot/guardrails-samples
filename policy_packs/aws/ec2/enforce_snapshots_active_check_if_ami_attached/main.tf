resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS EC2 Snapshots Active - Check if AMI Attached"
  description = "Enforce that AWS EC2 snapshots are active, but set to CHECK if the snapshot is attached to an AMI for safety."
  akas        = ["aws_ec2_enforce_snapshots_active_check_if_ami_attached"]
}

# Uncomment the block below to attach the policy pack to a specific resource for testing or knowledge building.
# For production, it is recommended to attach the policy pack manually in the Guardrails UI.
#
# resource "turbot_policy_pack_attachment" "test" {
#   policy_pack = turbot_policy_pack.main.id
#   resource    = "289217437897594"
# }
