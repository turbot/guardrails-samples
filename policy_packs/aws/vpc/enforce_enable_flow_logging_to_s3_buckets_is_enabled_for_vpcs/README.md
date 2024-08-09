---
categories: ["logging", "networking", "security"]
primary_category: "logging"
---

# Enforce Flow Logging to S3 Buckets Is Enabled for AWS VPCs

Enforcing flow logging to S3 buckets for AWS VPCs is crucial for maintaining comprehensive visibility and auditability of network traffic within your VPCs. This measure ensures that all network flow logs are stored securely in S3 buckets, facilitating detailed analysis, anomaly detection, and compliance with security best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for VPCs:

- Set S3 bucket name to which flow logging would be configured
- Enable flow logging to S3 bucket

## Documentation

- **[Review Policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_vpc_enforce_enable_flow_logging_to_s3_buckets_is_enabled_for_vpcs/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-vpc-core](https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc-core)

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
cd guardrails-samples/policy_packs/aws/vpc/enforce_enable_flow_logging_to_s3_buckets_is_enabled_for_vpcs
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

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "vpc_flow_logs" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  # value    = "Check: Configured per `Flow Logging > *`"
  value    = "Enforce: Configured per `Flow Logging > *`"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
