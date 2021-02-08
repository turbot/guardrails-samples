# Check unapproved IAM Group policy attachments based on name (e.g. FullAccess)

# Set policy to check unapproved policy attachments
# AWS > IAM > Group > Policy Attachments > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/groupPolicyAttachmentsApproved
resource "turbot_policy_setting" "aws_iam_group_policy_attachement_approved" {
    count     = var.enable_aws_iam_group_policy_attachement_approved ? 1 : 0
    resource  = turbot_smart_folder.aws_iam.id
    type      = "tmod:@turbot/aws-iam#/policy/types/groupPolicyAttachmentsApproved"
    value     = "Check: Approved"
             ## "Enforce: Delete unapproved"
}

# Identify policy names that are unapproved
# AWS > IAM > Group > Policy Attachments > Approved > Rules
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/groupPolicyAttachmentsApprovedRules
resource "turbot_policy_setting" "aws_iam_group_policy_attachement_rules" {
    count     = var.enable_aws_iam_group_policy_attachement_rules ? 1 : 0
    resource        = turbot_smart_folder.aws_iam.id
    type            = "tmod:@turbot/aws-iam#/policy/types/groupPolicyAttachmentsApprovedRules"
    value           = <<-POLICY
        REJECT $.PolicyName:/^.+FullAccess.*$/
        REJECT $.PolicyName:AdministratorAccess
        APPROVE *
        POLICY
}






