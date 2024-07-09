---
categories: ["security"]
description: "Prevent potential security breaches and enhance overall account security by requiring a second form of verification."
---

# Detect MFA is Enabled for AWS IAM Root Accounts

Ensuring Multi-Factor Authentication (MFA) is enabled for AWS IAM root accounts is critical as it provides an additional layer of security beyond just a password, significantly reducing the risk of unauthorized access. This protection helps prevent potential security breaches and enhances overall account security by requiring a second form of verification.

## Documentation

- **[Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/check_mfa_is_enabled_for_root_accounts/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-iam](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-iam)

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
cd guardrails-samples/policy_packs/aws/iam/check_mfa_is_enabled_for_root_accounts
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
