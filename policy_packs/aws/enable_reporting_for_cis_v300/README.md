---
categories: ["access management", "cis", "compliance", "logging", "networking", "security", "storage"]
primary_category: "compliance"
---

# Enable Reporting for AWS CIS v3.0.0

Enabling AWS CIS v3.0.0 is essential for ensuring that your AWS environment adheres to industry-recognized security best practices. This provides a robust framework for identifying and mitigating security risks, enhancing compliance with regulatory requirements, and protecting sensitive data by automatically enforcing the security configurations recommended by the CIS benchmarks.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you enable AWS CIS v3.0.0 reporting with and without attestation controls in Guardrails.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/aws/cis_v300/enable_cis_in_guardrails/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/aws-cisv3-0](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-cisv3-0)

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
> Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/cis_v300/enable_cis_in_guardrails
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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/smart-folders).

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policy is set to `Check: All CIS Benchmarks except attestations` which would enable all controls excluding the ones that need attestation. To enable all controls including the ones that need attestation, you can switch the policy setting by adding a comment to the `Check: All CIS Benchmarks except attestations` setting and removing the comment from `Check: All CIS Benchmarks`:

```hcl
resource "turbot_policy_setting" "aws_cis_v300" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-cisv3-0#/policy/types/cis"
  # value    = "Check: All CIS Benchmarks except attestations"
  value    = "Check: All CIS Benchmarks"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
