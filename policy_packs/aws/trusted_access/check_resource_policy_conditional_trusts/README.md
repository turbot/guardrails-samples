---
categories: ["access management", "security"]
primary_category: "security"
---

# Check Resource Policy Conditional Trusts for AWS Services

Ensuring that AWS resource policies properly restrict access to trusted organizations and accounts is crucial for maintaining security. This policy pack checks AWS Secrets Manager secrets to verify that resource policies either use organizational boundaries (aws:PrincipalOrgID condition) or limit access to explicitly trusted accounts only.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for AWS Secrets Manager:

- Check secrets for proper resource policy configurations
- Verify organizational boundary conditions (aws:PrincipalOrgID)
- Validate that only trusted accounts have access
- Identify secrets with overly permissive resource policies

## Documentation

- **[Review Policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_check_resource_policy_conditional_trusts/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)
  - [@turbot/aws-secretsmanager](https://hub.guardrails.turbot.com/mods/aws/mods/aws-secretsmanager)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Install Policy Pack

> [!NOTE]
> By default, installed policy packs are not attached to any resources.
>
> Policy packs must be attached to resources in order for their policy settings to take effect.

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/trusted_access/check_resource_policy_conditional_trusts
```

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Then apply the changes:

```sh
terraform apply
```

### Apply Policy Pack

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_secretsmanager_secret_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

### Configure Trusted Organizations and Accounts

This policy pack uses the AWS-level trusted organizations and accounts policies. Before using this pack, ensure you have configured:

- **AWS > Turbot > Trusted Organizations** - List of trusted AWS Organization IDs
- **AWS > Turbot > Trusted Accounts** - List of trusted AWS Account IDs

The custom approval logic will:
1. First check if the resource policy includes an `aws:PrincipalOrgID` condition limiting access to trusted organizations
2. If no organizational boundary exists, verify that all principals in the policy are from trusted accounts
3. Mark resources as approved only if they meet one of these criteria