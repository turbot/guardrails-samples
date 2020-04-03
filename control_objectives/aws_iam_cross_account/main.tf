
# Configure IAM Role trust relationship policy statements validation. This policy defines whether to check the role trust relationship policy statements are approved, 
# as well as the subsequent action to take on unapproved statements. Rules for all `Approved` policies will be compiled in `Approved > Compiled Rules` and then evaluated.
# If set to `Enforce: Delete unapproved`, any unapproved rules will be revoked from the IAM policy. Adjust the value in the bottom policy to match the accounts that
#  have cross account access approved from the organization.

# AWS > IAM > Role > Trust Relationship Statements > Approved*/
resource "turbot_policy_setting" "iam_trust_relationship_approved" {
    resource = turbot_smart_folder.iam_cross_account
    type = "tmod:@turbot/aws-iam#/policy/types/trustRelationshipStatementsApproved"
    value = "Check: Approved"
}

# Configuring IAM Trusted Accounts

/* Defines the AWS Accounts that can be allowed to assume the role.
  Examples:
    - "arn:aws:iam::560741234067:root"
    - 492552618977
    - 123456789012

  /n defines a new line and must be appended to any account added to the list in the policy
*/ 

# AWS > IAM > Role > Trust Relationship Statements > Approved > Trusted Accounts
resource "turbot_policy_setting" "iam_trustedaccounts" {
    resource = turbot_smart_folder.iam_cross_account.id
    type = "tmod:@turbot/aws-iam#/policy/types/trustRelationshipStatementsApprovedTrustedAwsAccounts"
    value = "- 123456789012/n- arn:aws:iam::560741234067:root/n- 492552618977"
}