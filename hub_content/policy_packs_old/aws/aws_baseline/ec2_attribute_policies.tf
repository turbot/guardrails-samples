#Restrict Turbot to only describing DisableApiTermination on EC2 Instances.
resource "turbot_policy_setting" "aws_ec2_instance_cmdb_attributes" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceCmdbAttributes"
  value    = <<EOT
- DisableApiTermination
EOT
}