resource "turbot_policy_setting" "kms_policy_approved" {
    resource        = turbot_smart_folder.kms_rules_approved_folder.id
    type            = "tmod:@turbot/aws-kms#/policy/types/keyPolicyStatementsApproved"
    value           = "Check: Approved"
}

resource "turbot_policy_setting" "kms_policy_rules" {
    resource        = <insert smart folder arn>
    type            = "tmod:@turbot/aws-kms#/policy/types/keyPolicyStatementsApprovedRules"
    template_input  = <<EOF
    {
        resource {
            policy: get (path:"Policy.Statement")
            metadata
        }
    }
    EOF
    template        = <<EOF
    REJECT $.Action:/^kms:(DescribeCustomKeyStores|ConnectCustomKeyStore|DeleteCustomKeyStore|DisconnectCustomKeyStore|UpdateCustomKeyStore|CreateCustomKeyStore|DisableKeyRotation|List\*|Get\*|Describe\*|\*)$/

    {% if $.CustomerMasterKeySpec != "SYMMETRIC_DEFAULT" -%}
    REJECT $.Action:/^kms:(GetPublicKey|Verify|Sign)$/
    {%- endif %}

    REJECT $.Action:/^kms:(Encrypt|Decrypt)$/ !$.Condition.StringEquals."kms:ViaService":"lambda.{{$.resource.metadata.aws.regionName}}.amazonaws.com","secretsmanager.{{$.resource.metadata.aws.regionName}}.amazonaws.com"

    REJECT $.Action:kms:ReEncryptTo !$.Principal.Service:"lambda.{{$.resource.metadata.aws.regionName}}.amazonaws.com","secretsmanager.{{$.resource.metadata.aws.regionName}}.amazonaws.com","ssm.{{$.resource.metadata.aws.regionName}}.amazonaws.com"

    {%- for item in $.resource.policy -%}
        {%- if (item.Principal.AWS[0] | length) == 1  -%}
            {%- set principals = [item.Principal.AWS] -%}
        {%- else -%}
            {%- set principals = item.Principal.AWS -%}
        {%- endif -%}
        {%- for arn in principals %}
            {% if r/pipeline/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:/^kms:(PutKeyPolicy|EnableKeyRotation|TagResource|CreateAlias|GetKeyPolicy|DeleteAlias|ListResourceTags|DisableKey|DeleteImportedKeyMaterial|ScheduleKeyDeletion|CancelKeyDeletion|DescribeKey|ListAliases|ListGrants|ListKeyPolicies|ListKeys|ListRetirableGrants|GetKeyRotationStatus)$/
            {% elif r/organizationaccountaccessrole/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:kms:PutKeyPolicy
            {% elif r/admin/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:kms:PutKeyPolicy
            {% elif r/securityaudit/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:/^kms:(DescribeKey|ListKeyPolicies|GetKeyPolicy)$/
            {% elif r/example-read-write-role/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:/^kms:(DescribeKey|ListAliases|ListGrants|ListKeyPolicies|ListKeys|ListResourceTags|ListRetirableGrants|GetKeyPolicy|GetKeyRotationStatus)$/
            {% elif r/another-read-only-role/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:/^kms:(DescribeKey|ListAliases|ListGrants|ListKeyPolicies|ListKeys|ListResourceTags|ListRetirableGrants|GetKeyPolicy|GetKeyRotationStatus|Decrypt)$/
            {% elif r/test-turbot-role/.test(arn | lower) %}
                REJECT $.Principal.AWS:{{arn}} !$.Action:/^kms:(DescribeKey|ListAliases|ListGrants|ListKeyPolicies|ListKeys|ListResourceTags|ListRetirableGrants|GetKeyPolicy|GetKeyRotationStatus)$/
            {% endif %}
        {%- endfor %}
    {%- endfor %}

    APPROVE *
    EOF
}