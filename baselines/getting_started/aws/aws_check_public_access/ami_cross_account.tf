# Restrict Public and Cross Account AMI Sharing

# Check on shared AMI to untrusted AWS Account; Account Trust set in variables
# AWS > EC2 > AMI > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/amiTrustedAccess
resource "turbot_policy_setting" "aws_ec2_ami_trusted_access" {
  count    = var.enable_aws_ec2_ami_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  #value   = "Enforce: Trusted Access > Accounts"
}

# ### Original Calc Policy on LaunchPermissions and Public
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
