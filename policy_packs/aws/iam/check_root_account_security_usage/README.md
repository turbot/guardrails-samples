---
categories: ["access management", "security"]
primary_category: "security"
---

# Check Root Account Access Usage

Monitoring access activity for AWS IAM root accounts is essential for maintaining a secure cloud environment. This policy checks for critical access indicators that could pose security risks if left unmonitored — including MFA status, recent usage of the root password, and access key activity.

Root accounts are highly privileged and should ideally remain unused. This policy ensures that any recent access patterns — whether via password or keys — are detected and flagged if they fall outside the approved window.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you enforce the following controls on IAM root accounts:
	- Check and alert if MFA is not enabled
	- Detect if the root password was used in the last 14 days
	- Check if Access Key 1 or Access Key 2 was used within the last 14 days
	- Identify active access keys that are unused but still present

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_iam_check_mfa_is_enabled_for_root_accounts/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-iam](https://hub.guardrails.turbot.com/mods/aws/mods/aws-iam)

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
cd guardrails-samples/policy_packs/aws/iam/check_root_account_access_usage
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
