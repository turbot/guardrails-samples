---
categories: ["compute", "security"]
primary_category: "security"
---

# Deny AWS EC2 Instances with Unapproved AMIs or Publisher Accounts

Denying AWS EC2 instances with unapproved AMIs and/or publisher accounts is essential to maintain a secure and controlled environment. This prevents the use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed, thereby reducing security risks and maintaining compliance with organizational policies.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for EC2 instances:

- Enforce a lockdown IAM policy via Guardrails to deny launching EC2 instances with unapproved AMIs and/or publishers
- Set the AMI IDs that are approved for use
- Set the publisher account IDs that are approved for use

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_ec2_deny_unapproved_amis_publishers_for_instances/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-ec2](https://hub.guardrails.turbot.com/mods/aws/mods/aws-ec2)

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
cd guardrails-samples/policy_packs/aws/ec2/deny_unapproved_amis_publishers_for_instances
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

By default, the lockdown policy is set to `Lockdown: Disabled` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Lockdown: Disabled` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_ec2_permissions_lockdown_instance_image" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2PermissionsLockdownInstanceImage"
  # value    = "Lockdown Disabled"
  # value    = "Lockdown Enabled: Allow Image > AMI IDs only"
  # value    = "Lockdown Enabled: Allow Image > Publishers only"
  # value    = "Lockdown Enabled: Allow Image > AMI IDs or Image > Publishers"
  value    = "Lockdown Enabled: Allow Image > AMI IDs from Image > Publishers"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
