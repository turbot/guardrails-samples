---
categories: ["compliance"]
primary_category: "compliance"
---

# Enforce AWS Account Organization Name Display

Automatically set AWS account aliases using organization account names for accounts that are part of an AWS organization. This policy pack enables a more user-friendly navigation experience by setting account aliases that will be displayed in breadcrumbs instead of numerical account IDs.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for AWS accounts:

- Automatically set account aliases using AWS organization account names
- Use Stack Native policies to manage account aliases as infrastructure
- Ensure account aliases are displayed in breadcrumbs instead of account numbers

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_guardrails_enforce_account_organization_name_display/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)

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
cd guardrails-samples/policy_packs/aws/guardrails/enforce_account_organization_name_display
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

By default, the policies are set to `Check: Configured` in the pack's policy settings. To enable automated enforcement, you can switch the policy setting:

```hcl
resource "turbot_policy_setting" "aws_account_stack_native" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/accountStackNative"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

## How It Works

This policy pack uses **Stack Native** policies to automatically manage AWS account aliases with a simple priority system:

1. **Account has alias**: Do nothing (existing alias takes precedence)
2. **Account has organization name only**: Create alias from sanitized organization name
3. **Account has neither**: Do nothing (account number displays)

The policy accesses account data via `$.account.Name` (organization name) and `$.account.AccountAlias` (existing alias).

### Priority Logic

**Existing account aliases always take precedence** because they were explicitly set by users. The policy will only create new aliases when no alias exists and an organization name is available.

### Example

For an account with the following properties:
- Account ID: `199816167099`
- Organization Name: `iog-prod-ict-cloud-shared-services`

The policy will:
1. **Sanitize** the name: `iog-prod-ict-cloud-shared-services` (already compliant)
2. **Create** an `aws_iam_account_alias` resource in the account
3. **Set** the account alias to `iog-prod-ict-cloud-shared-services`
4. **Display** the alias in breadcrumbs instead of the account number

**Breadcrumb Display**:
- **Before**: `Turbot > AWS > o-p6f4pvkbm0 > r-bk5e > 199816167099`
- **After**: `Turbot > AWS > o-p6f4pvkbm0 > r-bk5e > iog-prod-ict-cloud-shared-services`

### Name Sanitization Examples

The policy uses a robust sanitization algorithm that converts organization names to AWS-compliant aliases:

| Original Organization Name | Sanitized Account Alias |
|----------------------------|-------------------------|
| `iog-prod-ict-cloud-shared-services` | `iog-prod-ict-cloud-shared-services` |
| `My Company (Production)` | `my-company-production` |
| `Dev_Environment@2024` | `dev-environment-2024` |
| `Test.Account.Name` | `test-account-name` |
| `Very Long Organization Name That Exceeds AWS Limits` | `very-long-organization-name-that-exceeds-aws-limits` |
| `XY` | No alias created (account number displays) |
| `A` | No alias created (account number displays) |

**Sanitization Rules:**
- Converts to lowercase
- Keeps only alphanumeric characters and hyphens
- Removes consecutive hyphens
- Removes leading/trailing hyphens
- Truncates to 63 characters (AWS limit)
- Only creates alias if 3-63 characters (otherwise account number displays)

## Prerequisites

- AWS accounts must be imported into Guardrails
- For organization names to be available, accounts must be part of an AWS organization
- The Guardrails service role must have permissions to:
  - Read AWS Organizations data
  - Create/update IAM account aliases (`iam:CreateAccountAlias`, `iam:DeleteAccountAlias`, `iam:ListAccountAliases`)
