#AWS > EC2 > Instace > Approved > Usage
resource "turbot_policy_setting" "aws_ec2_approved_usage" { 
    resource = turbot_smart_folder.aws_ec2_folder.id
    type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedUsage"
    # GraphQL to pull function metadata
    template_input = <<-QUERY
-   | 
    {
        resource {
            image: get (path:"Image.ImageId")
        }
    }

-   |
    {
        resources(filter: "resourceType:'tmod:@turbot/aws-ec2#/resource/types/Ami' $.ImageId:'{{$.resource.image}}'") {
            items {
                tags
                public:get (path: "Public")
            }
        }
    } 
    QUERY 
    ## Nunjucks template evaluate metadata. 
    template = <<-TEMPLATE
    {%- set approved = "Approved" -%}

    {%- if $.resources.items[0].public == true -%}
    {%- set approved = "Not approved" -%}
    {%- elif not $.resources.items[0].tags -%}
    {%- set approved = "Not approved" -%}
    {%- elif not $.resources.items[0].tags['approved'] -%}
    {%- set approved = "Not approved" -%}
    {%- elif not $.resources.items[0].tags['approved'] == "yes" -%}
    {%- set approved = "Not approved" -%}
    {%- endif -%}

    {{ approved }}
    TEMPLATE
} 

#AWS > EC2 > Instance > Approved 
resource "turbot_policy_setting" "ec2_approved" {
  resource  = turbot_smart_folder.aws_ec2_folder.id
  type      = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value     = "Check: Approved"
}