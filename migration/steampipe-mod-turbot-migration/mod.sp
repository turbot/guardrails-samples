mod "migration_checks" {
  # hub metadata
  title         = "Pre, Intra and Post Checks for v3 to v5 Migrations"
  description   = "Examine pre-conditions, intermediate checks and post-migration checks to make account migration faster and smoother"
  color         = "#FCC119"
  documentation = file("./docs/index.md")
}

benchmark "pre" {
    title = "Pre-Migration Health Checks"
    description = "A list of checks to get baseline data before an account is migrated"
    children = [
    control.iam_turbot_groups_non_users,
    control.iam_turbot_users_non_groups,
    control.iam_turbot_users_nonturbot_policies,
    control.iam_turbot_users_with_inline_policies,
    control.iam_turbot_policies_attached_groups,
    control.iam_turbot_policies_attached_users,
    control.iam_turbot_policies_attached_roles,
    control.iam_users_two_keys
    ]
}

benchmark "inventory" {
    title = "Inventory of AWS resources"
    description = "Inventory dumps"
    children = [
        control.iam_turbot_all_groups_all_users,
        control.iam_turbot_all_groups_all_users_post,
        control.iam_users_groups
        ]
}
benchmark "post" {
    title = "Post-migration Health Checks"
    description = "Checks after the account has been migrated"
     children = [

     ]
}

control "iam_users_two_keys" {
    title = "IAM - Turbot Users with two AWS Access Keys"
    description = "Enumerate those users with two AWS Access keys"
    sql = query.iam_users_two_keys.sql
}
control "iam_users_groups" {
    title = "IAM - Enumerate all users in all Groups"
    description = "Enumerate all groups and all users in those groups.  Misses Users not in any groups. Does not examine policies in anyway."
    sql = query.iam_users_groups.sql
}

control "iam_turbot_all_groups_all_users_post" {
    title = "IAM - Compare Pre Groups&Users with Post Groups&Users"
    description = "Compare the list of pre-migration groups and users with the groups and users currently in AWS.  See the Readme for more details on how to run this control."
    sql = query.iam_turbot_all_groups_all_users_post.sql
}

control "iam_turbot_all_groups_all_users" {
    title = "IAM - List all Turbot-managed users in all Turbot-managed Groups"
    description = "Used to verify that the migration was successful by comparing user+groups before and after migration."
    sql = query.iam_turbot_all_groups_all_users.sql
}


# Waiting on a bug fix to get working. https://github.com/turbot/steampipe/issues/1688
#control "iam_turbot_grants_vs_aws" {
#    title = "IAM - Compare Turbot Grants exports to AWS"
#    description = "Compare Turbot Grants to AWS.  Read CSV and AWS then compare"
#    sql = query.iam_turbot_grants_vs_aws.sql
#    param "account" {
#        default = var.account
#    }
#}
#
#variable "account" {
#    type = string
#}

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
    title = "IAM - Turbot policies attached to non-Turbot Users"
    description = "List of Turbot policies attached to non-Turbot Users"
    sql = query.iam_turbot_policies_attached_users.sql
}

control "iam_turbot_policies_attached_roles" {
    title = "IAM - Turbot policies attached to non-Turbot Roles"
    description = "List of Turbot policies attached to non-Turbot Roles"
    sql = query.iam_turbot_policies_attached_roles.sql
}

control "iam_turbot_groups_non_users" {
    title = "IAM - Turbot Groups with non-Turbot users"
    description = "List of Turbot Groups with non-Turbot Users in them"
    sql = query.iam_turbot_groups_non_users.sql
}

control "iam_turbot_users_non_groups" {
    title = "IAM - Turbot users  non-Turbot groups"
    description = "List of Turbot users belonging to non-Turbot Groups"
    sql = query.iam_turbot_users_non_groups.sql
}

#control "iam_non_turbot_policies" {
#  title = "IAM - Turbot IAM Users with non-Turbot IAM policies"
#  description = "Identify Turbot managed IAM users that have third party IAM policies (inline and managed) attached"
#  sql = query.iam_non_turbot_policies.sql
#}




