
## Create a smart folder that houses the AWS IAM policy settings
resource "turbot_smart_folder" "iam_policy_folder" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the IAM Policy restrict settings"
  parent        = "tmod:@turbot/turbot#/"
}

## AWS > IAM > Policy > Approved
## Tell Turbot to check all IAM policies in target resource
resource "turbot_policy_setting" "iam_policy_approved" {
    resource = turbot_smart_folder.iam_policy_folder.id
    type = "tmod:@turbot/aws-iam#/policy/types/iamPolicyApproved"
    value = "Check: Approved"
}

## IAM Policy Approved - Turbot Policies
## AWS > IAM > Policy > Approved > Turbot
## Allows Turbot policies to exist without alarming
resource "turbot_policy_setting" "iam_policy_approved_turbot" {
    resource = turbot_smart_folder.iam_policy_folder.id
    type = "tmod:@turbot/aws-iam#/policy/types/iamPolicyApprovedTurbot"
    value = "Force Approved for Turbot Policies"
}


## Setting Policy Statements Approved to Check Only
## AWS > IAM > Policy > Statements > Approved
resource "turbot_policy_setting" "iam_policy_statements_approved" {
    resource = turbot_smart_folder.iam_policy_folder.id
    type = "tmod:@turbot/aws-iam#/policy/types/statementsApproved"
    value = "Check: Approved"
}

## Setting IAM Policy statements to not allow * actions
## AWS > IAM > Policy > Statements > Approved > Administrator Access
## If set to "Disabled", IAM Policy statements that allow any action ('*') on any resource ('*') will be unapproved.
resource "turbot_policy_setting" "iam_policy_statements_approved_adminaccess" {
    resource = turbot_smart_folder.iam_policy_folder.id
    type = "tmod:@turbot/aws-iam#/policy/types/statementsApprovedAdminAccess"
    value = "Disabled: Disallow Administrator Access ('*:*') policies"
}

## No inline IAM Policies

## Check for Inline Policies on IAM Roles
## AWS > IAM > Role > Inline Policy > Approved
resource "turbot_policy_setting" "iam_role_inlinepolicies" {
    resource = turbot_smart_folder.iam_policy_folder.id
    type = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyApproved"
    value = "Check: Approved"
}

## Set any Inline Policy on IAM Roles as not approved
## AWS > IAM > Role > Inline Policy > Approved > Usage
resource "turbot_policy_setting" "iam_role_inlinepolicies_usage" {
    resource = turbot_smart_folder.iam_policy_folder.id
    type = "tmod:@turbot/aws-iam#/policy/types/roleInlinePolicyApprovedUsage"
    value = "Not approved"
}
