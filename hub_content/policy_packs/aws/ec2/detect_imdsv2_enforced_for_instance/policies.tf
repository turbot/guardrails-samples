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
  template_input = <<-EOT
    {
      instance {
        httpTokens: get(path: "MetadataOptions.HttpTokens")
      }
    }
    EOT
  template       = <<-EOT
      {%- if $.instance.httpTokens == "required" -%}
        title: IMDSv2
        result: Approved
        message: "IMDSv2 is enforced for EC2 instance"
      {%- else -%}
        title: IMDSv2
        result: Not approved
        message: "IMDSv2 is not enforced for EC2 instance"
      {%- endif -%}
    EOT
}
