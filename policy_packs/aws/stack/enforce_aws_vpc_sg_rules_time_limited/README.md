---
categories: ["networking", "security", "stacks"]
primary_category: "networking"
---

# Enforce AWS VPC Security Group Rules with Time-Limited Exceptions

Apply temporary ingress and egress rules to existing security groups in a VPC using OpenTofu with `AWS > VPC > VPC > Stack [Native]` control with **time-limited exceptions**.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you securely configure existing AWS security groups by attaching controlled ingress and egress rules using the `AWS > VPC > VPC > Stack [Native]` control. Rules are automatically removed after the specified time duration for compliance automation.

> [!IMPORTANT]
> This policy pack expects **clean security groups** with no existing SSH (port 22) or RDP (port 3389) rules. Conflicting rules will cause `InvalidPermission.Duplicate` errors, which is expected behavior. To extend expiration time, update `exception_duration_hours` and run `terraform apply`.

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Clean security groups with no conflicting SSH/RDP rules

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
cd guardrails-samples/policy_packs/aws/stack/enforce_aws_vpc_sg_rules_time_limited
```

Configure time-limited exceptions in `terraform.tfvars`:

```hcl
# Enable time-limited exceptions for SSH (port 22) and RDP (port 3389) access
enable_time_limited_exceptions = true

# Duration in hours (1-168 hours, default: 4)
exception_duration_hours = 4
```

Set the VPC ID in `stack/variables.auto.tfvars`:

```hcl
vpc_id = "vpc-0123456789abcdef0"

# Optional: Filter security groups by tags (if specified, only matching SGs are updated)
# If no tags specified, ALL security groups in the VPC are updated
sg_tag_key = "Environment"
sg_tag_value = "Test"
```

> [!TIP] > **Security Group Targeting**: Specify `sg_tag_key` and `sg_tag_value` to target only security groups with matching tags. Leave empty to apply rules to **all** security groups in the VPC.

Deploy the policy pack:

```sh
terraform init
terraform plan
terraform apply
```

Attach the policy pack to resources in your Guardrails workspace. For more information, see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

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
