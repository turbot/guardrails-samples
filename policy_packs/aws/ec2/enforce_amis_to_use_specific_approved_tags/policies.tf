# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Instace > Approved > Custom
resource "turbot_policy_setting" "aws_ec2_instance_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedCustom"
  # Replace dummy value for inputTagKey in GraphQL query
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
        resources(filter: "resourceId:{{ $.region.turbot.id }} resourceTypeId:'tmod:@turbot/aws-ec2#/resource/types/ami' $.ImageId:'{{$.item.image}}' resourceTypeLevel:self") {
          items {
            tags
          }
        }
      }
    EOT
  # Replace dummy value for inputTagKeys in calculated policy
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
          "title": "EC2 AMIs Approved Tags",
          "result": "Approved",
          "message": "AMIs contains specific tags"
      } -%}

    {%- elif not isApproved -%}

      {%- set data = {
          "title": "EC2 AMIs Approved Tags",
          "result": "Not approved",
          "message": "AMIs do not contains specific tags"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "EC2 AMIs Approved Tags",
          "result": "Skip",
          "message": "No data for AMIs tags yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
