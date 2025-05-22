---
categories: ["networking", "stacks"]
primary_category: "stacks"
---

# Configure VPC Security Group Rules Stack

Apply ingress and egress rules to existing security groups in a VPC using OpenTofu with `AWS > VPC > VPC > Stack [Native]` control.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you securely configure existing AWS security groups by attaching controlled ingress and egress rules using the `AWS > VPC > VPC > Stack [Native]` control. You can customize the `Source`, but the example will apply port 22 and 3389 ingress from internal CIDRs, and egress for ports 443 and 80.

## Documentation

- **[Review Policy Settings →](https://hub.guardrails.turbot.com/policy-packs/aws_vpc_configure_vpc_sg_rules_stack/settings)**

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
cd guardrails-samples/policy_packs/aws/stack/configure_vpc_sg_rules_stack
```

The example `Source` applies the following to all or filtered security groups in a VPC:

- Ingress: Port 22 and 3389 from internal (RFC1918) IP ranges
- Egress: Port 443 and 80 to 0.0.0.0/0

You must set the following variable (in the `stack/variables.auto.tfvars` file):

```hcl
vpc_id = "vpc-0123456789abcdef0"
```

Optionally, set these to filter security groups:

```hcl
sg_tag_key = "Environment"
sg_tag_value = "Test"
```

Alternatively, modify the `Source` policy (in the `stack/source.tofu` file) and/or `Variables` policy (in the `stack/variables.auto.tfvars` file) to suit your use case.

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
terraform apply
```

### Apply Policy Pack

> [!IMPORTANT]
> Attaching this policy pack in Guardrails will result in security group rule changes in the target account. You can later remove them by setting the Stack's Source policy to `{}` (empty).

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all VPCs in that folder. The policy pack can also be attached to individual VPC resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check`. To enable automated enforcement, change to `Enforce: Configured`:

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
