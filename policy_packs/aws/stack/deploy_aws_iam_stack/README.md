---
categories: ["access management", "stacks"]
primary_category: "stacks"
---

# Deploy AWS IAM Stack

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you deploy, configure, and manage standard account-level IAM resources using the `AWS > IAM > Stack [Native]` control. You can customize the `Source`, but the example will create a simple IAM role.

## Documentation

- **[Review Policy settings →](https://hub.guardrails.turbot.com/policy-packs/deploy_aws_iam_stack/settings)**

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
cd guardrails-samples/policy_packs/aws/stack/deploy_aws_iam_stack
```


The example `Source` will create a read-only IAM role. You must set the `trusted_principals` variable (in the `stack/variables.auto.tfvars` file) to a valid ARN if you want to run the example as-is:

```hcl
trusted_principals =  ["arn:aws:iam::123456789012:root"]
```

Alternatively, modify the `Source` policy (in the `stack/source.tofu` file) and/or `Variables` policy (in the `stack/variables.auto.tfvars` file) to match you standards.  

There are additional stack-related example policies that are commented out in the `policies.tf` that you may choose to edit as well:
- `AWS > IAM > Stack [Native] > Secret Variables`
- `AWS > IAM > Stack [Native] > Modifier`
- `AWS > IAM > Stack [Native] > Timeout`
- `AWS > IAM > Stack [Native] > Version`
- `AWS > IAM > Stack [Native] > Drift Detection`
- `AWS > IAM > Stack [Native] > Drift Detection > Interval`
 

When you are ready to install the policy pack, run the Terraform commands to create the policy pack in your workspace:

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

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
# AWS > IAM > Stack [Native]
resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/iamStackNative"
  #value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```