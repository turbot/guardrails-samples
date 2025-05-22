---
categories: ["networking", "stacks"]
primary_category: "stacks"
---

# Deploy AWS VPC Security Group Stack

Deploy and manage a security group within an existing AWS VPC using OpenTofu with `AWS > VPC > VPC > Stack [Native]` control.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you deploy a secure and consistent VPC security group using the `AWS > VPC > VPC > Stack [Native]` control. You can customize the `Source`, but the example will create a security group with controlled ingress and egress rules.

## Documentation

- **[Review Policy Settings →](https://hub.guardrails.turbot.com/policy-packs/aws_vpc_deploy_vpc_security_group_stack/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

- Guardrails mods:
  - [@turbot/aws-vpc-core](https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-core)
  - [@turbot/aws-vpc-security](https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-security)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=your-access-key
export TURBOT_SECRET_KEY=your-secret-key
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
cd guardrails-samples/policy_packs/aws/stack/deploy_vpc_security_group_stack
```

The example `Source` will create a security group with HTTPS ingress from a trusted CIDR block, and egress rules for HTTPS and DNS. You must set the following variables (in `stack/variables.auto.tfvars` file) to use the example as-is:

```hcl
vpc_id = "vpc-0123456789abcdef0"
trusted_cidr_block = "203.0.113.0/24"
```

Alternatively, modify the `Source` policy (in `stack/source.tofu` file) and/or `Variables` policy (in `stack/variables.auto.tfvars` file) to meet your standards.

There are additional stack-related example policies that are commented out in `policies.tf` that you may choose to edit as well:

- `AWS > VPC > VPC > Stack [Native] > Secret Variables`
- `AWS > VPC > VPC > Stack [Native] > Modifier`
- `AWS > VPC > VPC > Stack [Native] > Timeout`
- `AWS > VPC > VPC > Stack [Native] > Version`
- `AWS > VPC > VPC > Stack [Native] > Drift Detection`
- `AWS > VPC > VPC > Stack [Native] > Drift Detection > Interval`

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
terraform apply
```

Then apply the changes:

```sh
terraform apply
```

### Apply Policy Pack

> [!IMPORTANT]
> Attaching this policy pack in Guardrails will result in creation of resources in the target account. However, it is easy to remove those resources later, by setting the contents of the Stack's Source policy to `{}` (empty).

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all VPCs in that folder. The policy pack can also be attached to individual VPC resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
# AWS > VPC > VPC > Stack [Native]
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNative"
  # value = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
