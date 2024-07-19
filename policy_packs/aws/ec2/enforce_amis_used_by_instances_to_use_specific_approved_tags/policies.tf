# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Instace > Approved > Custom
resource "turbot_policy_setting" "aws_ec2_instance_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedCustom"
  template_input = <<-EOT
    - |
      {
        item: instance {
          image: get(path: "ImageId")
        }
        region {
          turbot {
            id
          }
        }
      }
    - |
      {
        resources(filter: "resourceId:{{ $.region.turbot.id }} resourceTypeId:'tmod:@turbot/aws-ec2#/resource/types/ami' $.ImageId:'{{ $.item.image }}' resourceTypeLevel:self") {
          items {
            tags
          }
        }
      }
    EOT
  # Replace your list of approved tags in inputTagKeys
  template = <<-EOT
    {%- set tags = $.resources.items[0].tags -%}

    {%- set inputTagKeys = ["name", "environment"] -%}

    {%- set tagsLength = tags | length -%}

    {%- set allTagsPresent = true -%}

    {%- set flag = true -%}

    {%- if tagsLength > 0 -%}

      {%- for key in inputTagKeys -%}

        {%- if flag and key not in tags -%}

          {%- set allTagsPresent = false -%}

          {%- set flag = false -%}

        {%- endif -%}

      {%- endfor -%}
    {%- endif -%}

    {%- if tagsLength > 0 and allTagsPresent -%}

      {%- set data = {
          "title": "AMI Tags",
          "result": "Approved",
          "message": "AMI has approved tags"
      } -%}

    {%- elif tagsLength == 0 or not allTagsPresent -%}

      {%- set data = {
          "title": "AMI Tags",
          "result": "Not approved",
          "message": "AMI does not have approved tags"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "AMI Tags",
          "result": "Skip",
          "message": "No data for AMI tags yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
