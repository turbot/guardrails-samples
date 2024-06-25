---
categories: ["security"]
---

# Deny Unapproved AMIs for AWS EC2 Instances

Denying AWS EC2 instances with unapproved AMIs and/or publisher accounts is essential to maintain a secure and controlled environment. This prevents the use of potentially vulnerable or malicious images, ensuring that only vetted and compliant resources are deployed, thereby reducing security risks and maintaining compliance with organizational policies.

This policy pack can help you configure the following settings for AWS accounts:
- Update IAM policies to restrict EC2 instance creation to approved AMI IDs and publishers

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/deny_unapproved_amis_publishers_for_instances/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- The following Guardrails mods need to be installed:
  - [@turbot/aws-ec2](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-ec2)

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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Lockdown Disabled` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Lockdown Disabled` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_ec2_permissions_lockdown_instance_image" {
  resource = turbot_smart_folder.main.id
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
