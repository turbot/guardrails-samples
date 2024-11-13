# AWS > EC2 > Instance > Approved > Region
resource "turbot_policy_setting" "aws_ec2_instance_approved_region" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedRegion"
  value    = "Check: Approved region"
  # value    = "Enforce: Stop if unapproved region"
  # value    = "Enforce: Stop if unapproved region and new"
  # value    = "Enforce: Delete if unapproved region and new"
}

# AWS > EC2 > Instance > Approved > Region > Regions
resource "turbot_policy_setting" "aws_ec2_instance_approved_region_regions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedRegionRegions"
  value    = <<-EOT
    - "us-east-1"
    - "us-east-2"
  EOT
}
