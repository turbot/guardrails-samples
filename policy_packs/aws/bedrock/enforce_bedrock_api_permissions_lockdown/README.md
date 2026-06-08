---
categories: ["ai", "access management", "security"]
primary_category: "ai"
---

# Enforce AWS Bedrock API Permissions Lockdown

Guardrails manages the IAM permissions granted to Guardrails-managed users and roles for each AWS service. For [Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/what-is-bedrock.html), the permission policies determine whether those identities can access the Bedrock service and its API. Governing these settings lets you control exactly who can invoke Bedrock through Guardrails-managed access.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for Amazon Bedrock:

- Tie Bedrock permissions to whether the service and API are enabled
- Enable or disable the Bedrock service for Guardrails-managed identities
- Enable or disable the Bedrock API for Guardrails-managed identities

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_bedrock_enforce_bedrock_api_permissions_lockdown/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-bedrock](https://hub.guardrails.turbot.com/mods/aws/mods/aws-bedrock)

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
cd guardrails-samples/policy_packs/aws/bedrock/enforce_bedrock_api_permissions_lockdown
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

By default, the Bedrock service and API are enabled for Guardrails-managed identities. To lock down access, you can switch these policy settings by adding a comment to the active setting and removing the comment from one of the listed options:

```hcl
resource "turbot_policy_setting" "aws_bedrock_api_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-bedrock#/policy/types/bedrockApiEnabled"
  # value    = "Enabled"
  value    = "Disabled"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
