# Check unapproved IAM Role policy attachments based on name (e.g. FullAccess)

# Set policy to check unapproved policy attachments
# AWS > IAM > Role > Policy Attachments > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/rolePolicyAttachmentsApproved
resource "turbot_policy_setting" "aws_iam_role_policy_attachement_approved" {
    resource        = turbot_smart_folder.aws_iam.id
    type            = "tmod:@turbot/aws-iam#/policy/types/rolePolicyAttachmentsApproved"
    value           = "Check: Approved"
                      ## "Enforce: Delete unapproved"
}

# Identify policy names that are unapproved
# AWS > IAM > Role > Policy Attachments > Approved > Rules
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/rolePolicyAttachmentsApprovedRules
resource "turbot_policy_setting" "aws_iam_role_policy_attachement_rules" {
    resource        = turbot_smart_folder.aws_iam.id
    type            = "tmod:@turbot/aws-iam#/policy/types/rolePolicyAttachmentsApprovedRules"
    value           = <<-POLICY
        REJECT $.PolicyName:/^.+FullAccess.*$/
        REJECT $.PolicyName:AdministratorAccess
        APPROVE *
        POLICY
}
