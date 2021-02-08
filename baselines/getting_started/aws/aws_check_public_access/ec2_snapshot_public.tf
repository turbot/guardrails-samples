# Check for Cross Account EC2 Snapshot Sharing

# AWS > EC2 > Snapshot > Trusted Access
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotTrustedAccess
resource "turbot_policy_setting" "ec2_snapshot_trusted_access" {
  count    = var.enable_ec2_snapshot_trusted_access ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotTrustedAccess"
  value    = "Check: Trusted Access > Accounts"
  #value   = "Enforce: Trusted Access > Accounts"
}

# ### Original Calc Policy on LaunchPermissions and Public
# AWS > EC2 > Snapshot > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/snapshotApprovedUsage
resource "turbot_policy_setting" "ec2_snapshot_approved_usage" {
  count    = var.enable_ec2_snapshot_approved_usage ? 1 : 0
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
