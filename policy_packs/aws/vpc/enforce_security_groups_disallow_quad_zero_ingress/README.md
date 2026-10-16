---
categories: ["networking", "security"]
primary_category: "security"
---
# Enforce Quad-Zero Ingress Rules Are Blocked for AWS VPC Security Groups

Security group ingress rules open to the entire internet — `0.0.0.0/0` (IPv4) or `::/0` (IPv6) — on any protocol or port ("quad-zero" rules) are one of the most common causes of unintended public exposure. This policy pack detects such rules and can automatically remediate them, while honoring a tag-based exception model so approved use cases (for example, public load balancers) can opt out at either the security group or account level.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for VPC security groups:

- Reject any ingress rule whose source is `0.0.0.0/0` or `::/0`, on any protocol or port.
- Skip enforcement for security groups that carry an exception tag, or that live in an account carrying it (a [calculated policy](https://turbot.com/guardrails/docs/guides/calculated-policies) reads the tags from the CMDB at runtime).
- Support a phased rollout: `Check: Approved` first (report only), then `Enforce: Delete unapproved` (revoke non-compliant rules).

## Exception model

The `AWS > VPC > Security Group > Ingress Rules > Approved` policy is set as a calculated policy. For each security group it evaluates:

| Condition                                  | Policy value                                            |
| ------------------------------------------ | ------------------------------------------------------- |
| Security group has tag`quad-zero = true` | `Skip`                                                |
| Parent account has tag`quad-zero = true` | `Skip`                                                |
| Otherwise                                  | `Check: Approved` (or `Enforce: Delete unapproved`) |

Tag values are compared case-insensitively. The exception tag key and value (`quad-zero` / `true`) are defined directly in the calculated policy template in `policies.tf` — to use a different tag, edit the template and re-run `terraform apply`.

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_vpc_enforce_security_groups_disallow_quad_zero_ingress/settings)**
- **[Testing guide →](./TESTING.md)** — end-to-end functional test with disposable security groups
- **[Approved guardrail pattern →](https://turbot.com/guardrails/docs/guides/hosting-guardrails/guardrail-patterns)**
- **[OCL reference →](https://turbot.com/guardrails/docs/reference/ocl)**
- **[Calculated policies →](https://turbot.com/guardrails/docs/guides/calculated-policies)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-vpc-security](https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-security)

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
cd guardrails-samples/policy_packs/aws/vpc/enforce_security_groups_disallow_quad_zero_ingress
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

Attach the pack to the folder (or accounts) that should be governed — only resources under the attachment point are evaluated, so scoping to a specific set of accounts is done through where the pack is attached.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement (Phase 2)

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the calculated policy returns `Check: Approved` for non-excepted security groups. To enable automated enforcement, edit the template in `policies.tf` and change the else-branch value:

```hcl
    {%- else -%}
    "Enforce: Delete unapproved"
    {%- endif -%}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

Excepted (tagged) security groups remain skipped in both phases.
