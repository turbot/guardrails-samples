---
categories: ["data protection"]
primary_category: "data protection"
---

# Enforce Backups of EBS Volumes

Enforcing backups of EBS volumes provides a crucial defense against lost data. Guardrails uses the AWS Backup service to create and manage backups of EBS volumes. 

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings to create the required Backup IAM role, Backup Vaults, Backup Plans and Backup Selections. 

- Stop/Terminate replication instances which have public access enabled

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_dms_enforce_replication_instances_to_not_be_publicly_accessible/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- The following Guardrails mods need to be installed:
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)
  - [@turbot/aws-iam](https://hub.guardrails.turbot.com/mods/aws/mods/aws-iam)
  - [@turbot/aws-backup](https://hub.guardrails.turbot.com/mods/aws/mods/aws-backup)

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
cd guardrails-samples/policy_packs/aws/backup/enforce_ebs_volume_backups
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
resource "turbot_policy_setting" "aws_dms_replication_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-dms#/policy/types/replicationInstanceApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

## Decommission the Backups.
1. Edit the Backup > Stack > Source policy setting in the policy pack.
   1. **Flush Backups**: To flush the current backups, set the retention period to one day, as shown below. 
  2. **Prevent new backups**: Remove the Backup Selection from the `AWS > Backup > Stack > Source`.  This will prevent new backups from happening.

When the changes are complete the `template` attribute for `Backup > Stack > Source` should look like this. 
```hcl
    |
    resource "aws_backup_vault" "vault" {
      name = "guardrails-backup-vault"
      tags = {
        turbot_version = "v5"
      }
    }
    resource "aws_backup_plan" "guardrails_ebs_backups" {
      name = "guardrails-backup-plan"
      rule {
        # The time allowed for the job to start, any longer and it will be cancelled.
        start_window = 480
        # The amount of time allowed for the backup to complete, before it is cancelled.
        completion_window = 10080
        #
        rule_name         = "guardrails-ebs-backups-rule"
        schedule          = "cron(0 5 ? * * *)"
        target_vault_name = aws_backup_vault.vault.name
        lifecycle {
          delete_after = 1
        }
      }
    }
```

2. **Apply the policy pack changes**: Wait a day or two for the backups to be flushed from the Guardrails Backup vault.  AWS will not allow a vault to be destroyed when backups are still present. 
3. **Decommission the Backup Vault**: This is most easily done by replacing `template` and `template_input` attributes of `Backup > Stack > Source` as shown below. The `[]` value instructs the `Backup > Stack` control to destroy all managed resources. Apply the changes to the Policy Pack.
```hcl
# AWS > Backup > Stack > Source
resource "turbot_policy_setting" "aws_backup_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-backup#/policy/types/backupStackSource"
  value    = "[]"  
}
```
4. **Verify Vault Decommission**: Verify that all the `Backup > Stack` controls have gone into an `ok` state.  If they go into `error`, the `Backup > Stack` control logs should give a good indication of what's wrong.
5. **Remove Backup IAM Role**: Set the `AWS > IAM > Stack > Source` policy to the below Terraform:  This will remove the Backup IAM role.
```hcl
# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_iam_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  value    = "[]"
}
```
6. **Verify IAM Role Decommission**: Verify that all the `IAM > Stack` controls are in `ok`.
7. **Remove Policy Pack**: Remove the policy pack from your Guardrails workspace. 