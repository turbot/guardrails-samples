# AWS KMS - Alarm if unapproved permissions are detected in a KMS key policy
## Use case

This set of policies can be used to restrict or approve specific permissions on a KMS key. The logic can be dynamic such that policy rules are different across accounts or regions, for example.

## Implementation details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > KMS > Key > Policy > Statements > Approved`
- `AWS > KMS > Key > Policy > Statements > Approved > Rules`


The `AWS > KMS > Key > Policy > Statements > Approved > Rules` policy defines the permissions that are allowed to exist on the KMS Key policy, and the `AWS > KMS > Key > Policy > Statements > Approved` tells Turbot to check said policy (but not modify).

Note the use of the pipe (`|`) in the REJECT statements. These act as AND operators.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

```graphql
{
    resource {
        policy: get (path:"Policy.Statement")
        metadata
    }
} 
```

### Template (Nunjucks)

Approval logic for KMS Key policies

```nunjucks

# REJECT CustomKeyStore policies, List*, Get*, Describe*, and *

REJECT $.Action:/^kms:(DescribeCustomKeyStores|ConnectCustomKeyStore|DeleteCustomKeyStore|DisconnectCustomKeyStore|UpdateCustomKeyStore|CreateCustomKeyStore|DisableKeyRotation|List\*|Get\*|Describe\*|\*)$/

# If the KMS Key is not symmetric, REJECT GetPublicKey, Verify, and Sign

{% if $.CustomerMasterKeySpec != "SYMMETRIC_DEFAULT" -%}
REJECT $.Action:/^kms:(GetPublicKey|Verify|Sign)$/
{%- endif %}

# Build REJECT statement with the added condition that these policies can only be called via lambda and secrets manager services.

REJECT $.Action:/^kms:(Encrypt|Decrypt)$/ !$.Condition.StringEquals."kms:ViaService":"lambda.{{$.resource.metadata.aws.regionName}}.amazonaws.com","secretsmanager.{{$.resource.metadata.aws.regionName}}.amazonaws.com"

# Build REJECT statement with the added condition that these policies can only be called via the lambda, secrets manager, and ssm services.

REJECT $.Action:kms:ReEncryptTo !$.Principal.Service:"lambda.{{$.resource.metadata.aws.regionName}}.amazonaws.com","secretsmanager.{{$.resource.metadata.aws.regionName}}.amazonaws.com","ssm.{{$.resource.metadata.aws.regionName}}.amazonaws.com"

# Apply logic to build REJECT statements dynamically. In each if statement, regex is used to pick out the principal and apply the associated statements.

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
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- target_resource
- smart_folder_title (Optional)
- smart_folder_description (Optional)
- smart_folder_parent_resource (Optional)

Open the file [variables.tf](variables.tf) for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform apply -var-file=default.tfvars`

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`