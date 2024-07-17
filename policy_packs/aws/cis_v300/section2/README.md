---
categories: ["CIS"]
---

# AWS CIS v3.0.0 - Section 2 - Storage

This section contains recommendations for configuring AWS Storage.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you automate the enforcement of AWS CIS benchmark section 2 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/aws/cis_v300/section2/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/aws-ec2](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-ec2)
  - [@turbot/aws-efs](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-efs)
  - [@turbot/aws-rds](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-rds)
  - [@turbot/aws-s3](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-s3)

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
cd guardrails-samples/policy_packs/aws/cis_v300/section2
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

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.
> By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_s3_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
  note     = "AWS CIS v3.0.0 - Control: 2.1.1"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "aws_s3_s3_bucket_public_access_block" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/s3BucketPublicAccessBlock"
  note     = "AWS CIS v3.0.0 - Control: 2.1.4"
  # value    = "Check: Per `Public Access Block  > Settings`"
  value    = "Enforce: Per `Public Access Block  > Settings`"
}

resource "turbot_policy_setting" "aws_ec2_ec2_account_attributes_ebs_encryption_by_default" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2AccountAttributesEbsEncryptionByDefault"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  # value    = "Check: AWS managed key or higher"
  value    = "Enforce: AWS managed key or higher"
}

resource "turbot_policy_setting" "aws_ec2_volume_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  # value    = "Check: Approved"
  value    = "Enforce: Detach unapproved if new"
  # value    = "Enforce: Detach, snapshot and delete unapproved if new"
}

resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.2.1"
  # value    = "Check: Approved"
  value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "aws_rds_db_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.3.1"
  # value    = "Check: Approved"
  value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Snapshot and delete unapproved if new"
}

resource "turbot_policy_setting" "aws_rds_db_instance_auto_minor_version_upgrade" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceAutoMinorVersionUpgrade"
  note     = "AWS CIS v3.0.0 - Control: 2.3.2"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "aws_rds_db_instance_publicly_accessible" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstancePubliclyAccessible"
  note     = "AWS CIS v3.0.0 - Control: 2.3.3"
  # value    = "Check: DB Instance is not publicly accessible"
  value    = "Enforce: DB Instance is not publicly accessible"
}

resource "turbot_policy_setting" "aws_efs_file_system_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "aws_efs_mount_target_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-efs#/policy/types/mountTargetApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
  # value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
