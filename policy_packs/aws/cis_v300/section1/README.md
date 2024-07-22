---
categories: ["access management", "cis", "compliance", "security"]
primary_category: "compliance"
---

# AWS CIS v3.0.0 - Section 1 - Identity and Access Management

This section contains recommendations for configuring identity and access management related options.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you automate the enforcement of AWS CIS benchmark section 1 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/aws_cis_v300_section1/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-iam](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/mods/aws/mods/aws-iam)

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
cd guardrails-samples/policy_packs/aws/cis_v300/section1
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

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
  note     = "AWS CIS v3.0.0 - Controls: 1.8 & 1.9"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "aws_iam_access_key_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  note     = "AWS CIS v3.0.0 - Controls: 1.12, 1.13 & 1.14"
  # value    = "Check: Active"
  value    = "Enforce: Deactivate inactive with 14 days warning"
}

resource "turbot_policy_setting" "aws_iam_user_policy_attachments_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/userPolicyAttachmentsApproved"
  note     = "AWS CIS v3.0.0 - Controls: 1.15"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}

resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  note     = "AWS CIS v3.0.0 - Controls:  1.17"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "aws_ec2_instance_instance_profile" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceProfile"
  note     = "AWS CIS v3.0.0 - Controls: 1.18"
  # value    = "Check: Instance profile attached"
  # value    = "Check: Instance Profile > Name attached"
  value    = "Enforce: Attach Instance Profile > Name"
}

resource "turbot_policy_setting" "aws_iam_server_certificate_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/serverCertificateActive"
  note     = "AWS CIS v3.0.0 - Controls: 1.19"
  # value    = "Check: Active"
  value    = "Enforce: Delete inactive with 1 day warning"
}

resource "turbot_policy_setting" "aws_iam_regional_access_analyzer" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/regionStack"
  note     = "AWS CIS v3.0.0 - Controls: 1.20"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
