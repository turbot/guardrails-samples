# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Stop unapproved"
}

# AWS > EC2 > Instance > Custom
resource "turbot_policy_setting" "aws_ec2_instance_approved_custom" {
  resource       = turbot_smart_folder.pack.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedCustom"
  note           = "Detect if IMDSv2 is enforced for AWS EC2 instances"
  template_input = <<-EOT
    {
      instance {
        HttpTokens: get(path: "MetadataOptions.HttpTokens")
      }
    }
    EOT
  template       = <<-EOT
      {%- if $.instance.HttpTokens == "required" -%}
      result: Approved
      message: "IMDSv2 is enforced for EC2 instance"
      {%- else -%}
      result: Not approved
      message: "IMDSv2 is NOT enforced for EC2 instance"
      {%- endif -%}
    EOT
}
