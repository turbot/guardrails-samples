# AWS > KMS > Key > Policy Statements > Approved
resource "turbot_policy_setting" "aws_kms_key_policy_statements_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyPolicyStatementsApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > KMS > Key > Policy Statements > Approved > Rules
resource "turbot_policy_setting" "aws_kms_key_policy_statements_approved_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-kms#/policy/types/keyPolicyStatementsApprovedRules"
  template_input = <<-EOT
    {
      item: key {
        policy: get (path:"Policy.Statement")
        metadata
      }
    }
  EOT
  template       = <<-EOT
    REJECT $.Action:/^kms:(DescribeCustomKeyStores|ConnectCustomKeyStore|DeleteCustomKeyStore|DisconnectCustomKeyStore|UpdateCustomKeyStore|CreateCustomKeyStore|DisableKeyRotation|List\*|Get\*|Describe\*|\*)$/

    {% if $.CustomerMasterKeySpec != "SYMMETRIC_DEFAULT" -%}
    REJECT $.Action:/^kms:(GetPublicKey|Verify|Sign)$/
    {%- endif %}

    REJECT $.Action:/^kms:(Encrypt|Decrypt)$/ !$.Condition.StringEquals."kms:ViaService":"lambda.{{$.item.metadata.aws.regionName}}.amazonaws.com","secretsmanager.{{$.item.metadata.aws.regionName}}.amazonaws.com"
  EOT
}
