---
categories: ["security", "compute"]
primary_category: "security"
---

# Enforce AWS Lambda Functions to Restrict Public Access

Enforcing AWS Lambda functions to restrict public access is vital to prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches. By limiting access, you ensure that only authorized entities can execute the functions, thereby maintaining the integrity and confidentiality of your applications and data.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you configure the following settings for Lambda functions:

- Revoke untrusted access from the function's IAM resource policy
- Set trusted accounts for the IAM resource policy
- Set trusted services for the IAM resource policy

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_lambda_enforce_functions_to_restrict_public_access/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-lambda](https://hub.guardrails.turbot.com/mods/aws/mods/aws-lambda)

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
cd guardrails-samples/policy_packs/aws/lambda/enforce_functions_to_restrict_public_access
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

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_lambda_function_policy_trusted_access" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionPolicyTrustedAccess"
  # value    = "Check: Trusted Access"
  value    = "Enforce: Revoke untrusted access"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
