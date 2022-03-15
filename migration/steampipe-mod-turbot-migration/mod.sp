mod "migration_checks" {
  # hub metadata
  title         = "Pre, Intra and Post Checks for v3 to v5 Migrations"
  description   = "Examine pre-conditions, intermediate checks and post-migration checks to make account migration faster and smoother"
  color         = "#FCC119"
  documentation = file("./docs/index.md")
}

# DONE Turbot Managed IAM User with NonTurbot Attached Policy
# Turbot Managed IAM User with Inline Policy
# Turbot Managed IAM User with NonTurbot Group
# DONE Turbot Managed Group with NonTurbot managed Users
# DONE NonTurbot Managed Role with Turbot Managed IAM Policy
# DONE NonTurbot Managed User with Turbot Managed IAM Policy
# DONE NonTurbot Managed Group with Turbot Managed IAM Policy
# NonTurbot Managed User with Attached Turbot Managed IAM Policy
# NonTurbot Managed User Attached to Turbot Managed Group

benchmark "pre" {
    title = "Pre-Migration Health Checks"
    description = "A list of checks to get baseline data before an account is migrated"
    children = [
    control.iam_turbot_groups_non_users,
    control.iam_turbot_users_non_groups,
    control.iam_turbot_policies_attached_groups,
    control.iam_turbot_policies_attached_users,
    control.iam_turbot_policies_attached_roles,
    control.iam_turbot_users_nonturbot_policies,
    control.iam_turbot_users_with_inline_policies
    # Compare CSV of v3 grants with Omero's Terraform
    # Compare CSV of effective grants compared with what's in AWS
    # Get a list of Turbot-managed users in Turbot-managed groups
    ]

}
benchmark "post" {
    title = "Post-migration Health Checks"
    description = "Checks after the account has been migrated"
     children = [
     # Get a list of Turbot-managed users in Turbot-managed groups
     # Compare CSV of effective grants compared with what's in AWS
     # Compare pre-check of AWS groups+users with post-check of AWS groups+users

     ]
}

control "iam_turbot_users_with_inline_policies" {
    title = "IAM - Turbot Users with Inline Policies"
    description = "List of Turbot users with inline policies.  There should never be inline policies."
    sql = query.iam_turbot_users_with_inline_policies.sql
}


control "iam_turbot_users_nonturbot_policies" {
  title = "IAM - Turbot Users with NonTurbot Policies Attached"
  description = "List of Turbot users with nonTurbot managed policies attached."
  sql = query.iam_turbot_users_nonturbot_policies.sql
}


control "iam_turbot_policies_attached_groups" {
    title = "IAM - Turbot policies attached to non-Turbot Groups"
    description = "List of Turbot policies attached to non-Turbot Groups"
    sql = query.iam_turbot_policies_attached_groups.sql
}

control "iam_turbot_policies_attached_users" {
    title = "IAM - Turbot policies attached to non-Turbot Groups"
    description = "List of Turbot policies attached to non-Turbot Users"
    sql = query.iam_turbot_policies_attached_users.sql
}

control "iam_turbot_policies_attached_roles" {
    title = "IAM - Turbot policies attached to non-Turbot Groups"
    description = "List of Turbot policies attached to non-Turbot Roles"
    sql = query.iam_turbot_policies_attached_roles.sql
}

control "iam_turbot_groups_non_users" {
    title = "IAM - Turbot Groups with non-Turbot users"
    description = "List of Turbot Groups with non-Turbot Users in them"
    sql = query.iam_turbot_groups_non_users.sql
}

control "iam_turbot_users_non_groups" {
    title = "IAM - Turbot Groups with non-Turbot users"
    description = "List of Turbot users belonging to non-Turbot Groups"
    sql = query.iam_turbot_users_non_groups.sql
}

#control "iam_non_turbot_policies" {
#  title = "IAM - Turbot IAM Users with non-Turbot IAM policies"
#  description = "Identify Turbot managed IAM users that have third party IAM policies (inline and managed) attached"
#  sql = query.iam_non_turbot_policies.sql
#}
#
#control "iam_non_turbot_users" {
#title = "IAM - Turbot IAM Users with non-Turbot IAM policies"
#  sql = query.iam_non_turbot_users.sql
#}

#benchmark "ec2" {
#  title       = "AWS Health - EC2"
#  description = "Checks on EC2 Environment Health"
#  children    = [
#    control.ec2_missing_ami
#  ]
#}

#benchmark "iam" {
#
#  title = "AWS Health - IAM"
#  description = "Checks for IAM Environment Health"
#  children = [
#  control.iam_non_turbot_policies,
#  control.iam_non_turbot_users,
#  control.iam_turbot_groups_non_users]
#}
#control "ec2_missing_ami" {
# title       = "EC2 - Instances with Missing AMIs"
#  description = "A list of EC2 instances showing whether the AMI used to launch the instance is still present"
#  query         = query.ec2_missing_ami
#  args = {
#    shared_ami_owner = 707491007138
#  }
#}


