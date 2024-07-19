# AWS > EC2 > Account Attributes > Instance Metadata Service Defaults
resource "turbot_policy_setting" "aws_ec2_account_attributes_instance_metadata_service_defaults" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesInstanceMetadataServiceDefaults"
  note     = "AWS CIS v3.0.0 - Controls: 5.6"
  value    = "Check: Enabled for V2 only"
  # value    = "Enforce: Enabled for V2 only"
}
