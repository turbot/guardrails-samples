---
categories: ["networking", "security"]
primary_category: "networking"
---

# Deny all AWS IAM actions from Unapproved Networks

Denying all AWS IAM actions from unapproved networks is vital for protecting your AWS environment from unauthorized access. This measure ensures that IAM actions, such as creating, modifying, or deleting resources, can only be performed from trusted and approved networks, reducing the risk of malicious activity and enhancing overall security and compliance with best practices.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you configure the following settings for IAM:

- Create an IAM Boundary policy to allow IAM actions only to RFC 1918 CIDR ranges

## Documentation

- **[Review Policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_iam_deny_all_iam_actions_from_unapproved_networks/settings)**

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
cd guardrails-samples/policy_packs/aws/iam/deny_all_iam_actions_from_unapproved_networks
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

> [!IMPORTANT]
> Attaching this policy pack in Guardrails will result in creation of resources in the target account. However, it is easy to remove those resources later, by setting the contents of the Stack's Source policy to `{}` (empty).

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
resource "turbot_policy_setting" "aws_iam_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
