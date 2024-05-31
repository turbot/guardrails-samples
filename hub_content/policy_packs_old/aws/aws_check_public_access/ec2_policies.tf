# Public Access Guardrails - https://turbot.com/v5/docs/concepts/guardrails/public-access


# AWS > EC2 > Instance > Approved > Public IP
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceApprovedPublicIp
resource "turbot_policy_setting" "aws_ec2_instance_approved_public_ip" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedPublicIp"
  value    = "Approved if not assigned"
}

# EC2 Metadata security best practices is to enable v2 for session based authentication
# AWS > EC2 > Instance > Metadata Service
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceMetadataService
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataService"
  value    = "Check: Enabled for V2 only"
}

# EC2 Metadata security best practices.
# 1 Hop limit ensures the packet is dropped leaving the EC2 instance
# AWS > EC2 > Instance > Metadata Service > HTTP Token Hop Limit
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/instanceMetadataServiceTokenHopLimit
resource "turbot_policy_setting" "aws_ec2_instance_metadata_service_token_hop_limit" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceMetadataServiceTokenHopLimit"
  value    = "1"
}

# Restrict Public and Cross Account AMI Sharing

# Check on shared AMI to untrusted AWS Account; Account Trust set in variables
# AWS > EC2 > AMI > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/amiTrustedAccess
resource "turbot_policy_setting" "aws_ec2_ami_trusted_access" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  #value   = "Enforce: Trusted Access > Accounts"
}

# Original Calc Policy on LaunchPermissions and Public
# resource "turbot_policy_setting" "aws_ec2_ami_approved_usage" {
#   resource          = turbot_smart_folder.aws_public_access.id
#   type              = "tmod:@turbot/aws-ec2#/policy/types/amiApprovedUsage"
#   # GraphQL to pull policy Statements
#   template_input    = <<-QUERY
#     {
#         ami: resource {
#             permissions: get(path: "LaunchPermissions")
#             public: get(path: "Public")
#         }
#     }
#     QUERY
#
#   # Nunjucks template to set usage approval based on if the resource is shared to approved accounts.
#   # set trustedAccounts in terraform.tfvars
#   template          = <<-TEMPLATE
#     {%- set trustedAccounts = ${jsonencode([for account in var.trusted_accounts : account])} -%}
#     {%- set approved = "Approved" -%}
#     {%- for permission in $.ami.permissions -%}
#         {%- if permission.UserId not in trustedAccounts -%}
#             {%- set approved = "Not approved" -%}
#         {%- endif -%}
#     {%- endfor -%}
#     {%- if $.resource.public -%}
#         {%- set approved = "Not approved" -%}
#     {%- endif -%}
#     {{approved}}
#     TEMPLATE
# }

# Check for Cross Account EC2 Snapshot Sharing

# AWS > EC2 > Snapshot > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotTrustedAccess
resource "turbot_policy_setting" "ec2_snapshot_trusted_access" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  #value   = "Enforce: Trusted Access > Accounts"
}

# Original Calc Policy on LaunchPermissions and Public
# AWS > EC2 > Snapshot > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotApprovedUsage
resource "turbot_policy_setting" "ec2_snapshot_approved_usage" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotApprovedUsage"
  # GraphQL to pull metadata
  template_input = <<-QUERY
    {
        snapshot: resource {
            permissions: get(path: "snapshotAttributes.CreateVolumePermissions")
            public: get(path: "Public")
        }
    }
    QUERY
  # Nunjucks template to set usage approval based on if the resource is shared to approved accounts.
  # set trustedAccounts in demo.tfvars
  template = <<-TEMPLATE
    {%- set trustedAccounts = ${jsonencode([for account in var.trusted_accounts : account])} -%}
    {%- set approved = "Approved" -%}
    {%- for permission in $.snapshot.permissions -%}
      {%- if permission.UserId not in trustedAccounts -%}
        {%- set approved = "Not approved" -%}
      {%- endif -%}
    {%- endfor -%}
    {%- if $.snapshot.public -%}
      {%- set approved = "Not approved" -%}
    {%- endif -%}
    {{approved}}
    TEMPLATE
}
