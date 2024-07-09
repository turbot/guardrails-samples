---
categories: ["security"]
description: "Prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches."
---

# Enforce AWS Lambda Functions to Restrict Public Access

Enforcing AWS Lambda functions to restrict public access is vital to prevent unauthorized users from invoking functions, which can lead to security vulnerabilities and potential data breaches. By limiting access, you ensure that only authorized entities can execute the functions, thereby maintaining the integrity and confidentiality of your applications and data.

## Documentation

- **[Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_functions_to_restrict_public_access/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-lambda](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-lambda)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Owner` or `Turbot/Admin` permissions in Guardrails
- Create [Guardrails access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key)

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace-turbot.cloud.turbot.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please check [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

### Enable Enforcement

By default, the controls are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_lambda_function_policy_trusted_access" {
  resource = turbot_smart_folder.main.id
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

You can also update the policy setting on the policy pack directly in the Guardrails console.

Note: If modifying the policy setting in the console, your Terraform state file will become out of sync, so the policy settings should only be managed in the console.
