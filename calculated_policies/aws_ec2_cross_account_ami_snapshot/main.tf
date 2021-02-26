# Smart folder containing policies created below.
resource "turbot_smart_folder" "ec2_trusted_accounts" {
  parent      = var.smart_folder_parent_resource
  title       = var.smart_folder_title
  description = var.smart_folder_description
}

# Turbot file used to store approved account numbers.
# MODIFY THESE LISTS BEFORE APPLYING THE TERRAFORM PLAN!
resource "turbot_file" "trusted_accounts_list" {
  parent      = "tmod:@turbot/turbot#/"
  title       = var.turbot_file_name
  description = var.turbot_file_description
  akas        = var.file_aka
  content     = <<EOF
  {
    "snapshot_trusted_accounts" : [
      "567890123456",
      "012345678901"
    ],
    "ami_trusted_accounts" : [
      "234567890123",
      "345678901234"
    ]
  }
  EOF
}

# Sets the policy AWS > EC2 > Snapshot > Approved to "Check: Approved"
resource "turbot_policy_setting" "ec2_snapshot_ami_approved" {
  resource        = turbot_smart_folder.ec2_trusted_accounts.id
  type            = "tmod:@turbot/aws-ec2#/policy/types/snapshotApproved"
  value           = "Check: Approved"
}

# Sets a calculated policy AWS > EC2 > Snapshot > Approved > Usage
# Checks the snapshot shared account permissions and cross references them against the Turbot File.
# If there is any account that does not exist in the Turbot File, this policy is set to "Not Approved."
resource "turbot_policy_setting" "ec2_snapshot_approved_usage" {
  resource        = turbot_smart_folder.ec2_trusted_accounts.id
  type            = "tmod:@turbot/aws-ec2#/policy/types/snapshotApprovedUsage"
  # GraphQL to pull policy Statements
  template_input  = <<-QUERY
    {
      resource {
          permissions: get(path: "snapshotAttributes.CreateVolumePermissions")
      }
      list_trusted_accounts: resource(id:"list_accounts") {
        data
      }
    }
    QUERY
  
  # Nunjucks template to set usage approval based on if the resource is shared to approved accounts.
  template        = <<-TEMPLATE
    {%- set approved = true -%}
    {%- for permission in $.resource.permissions -%}
      {%- if permission.UserId not in $.list_trusted_accounts.data.snapshot_trusted_accounts -%}
        {%- set approved = false -%}
      {%- endif -%}
    {%- endfor -%}
    {%- if approved  -%}
      "Approved"
    {%- else -%}
      "Not approved"
    {%- endif -%}
    TEMPLATE
}

## Sets the policy AWS > EC2 > AMI > Approved to "Check: Approved"
resource "turbot_policy_setting" "ec2_ami_approved" {
  resource        = turbot_smart_folder.ec2_trusted_accounts.id
  type            = "tmod:@turbot/aws-ec2#/policy/types/amiApproved"
  value           = "Check: Approved"
}

# Sets a calculated policy AWS > EC2 > AMI > Approved > Usage
# Checks the snapshot shared account permissions and cross references them against the Turbot File.
# If there is any account that does not exist in the Turbot File, this policy is set to "Not Approved."
resource "turbot_policy_setting" "ec2_ami_approved_usage" {
  resource        = turbot_smart_folder.ec2_trusted_accounts.id
  type            = "tmod:@turbot/aws-ec2#/policy/types/amiApprovedUsage"
  # GraphQL to pull policy Statements
  template_input  = <<-QUERY
    {
        resource {
            permissions: get(path: "LaunchPermissions")
        }
      list_trusted_accounts: resource(id:"list_accounts") {
        data
      }
    }
    QUERY
  
  # Nunjucks template to set usage approval based on if the resource is shared to approved accounts.
  template        = <<-TEMPLATE
    {%- set approved = true -%}
    {%- for permission in $.resource.permissions -%}
        {%- if permission.UserId not in $.list_trusted_accounts.data.ami_trusted_accounts -%}
            {%- set approved = false -%}
        {%- endif -%}
    {%- endfor -%}
    {%- if approved  -%}
        "Approved"
    {%- else -%}
        "Not approved"
    {%- endif -%}
    TEMPLATE
}