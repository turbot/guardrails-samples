---
categories: ["backup", "compliance", "storage"]
primary_category: "backup"
---

# Enforce AWS RDS DB Instance Backup Retention Period

Enforcing a minimum backup retention period for AWS RDS DB instance automated backups is crucial for compliance, data protection, and cost management. This policy pack ensures that all RDS DB instances have a backup retention period set to your organization's requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for RDS DB instances:

- Enforce or check the backup retention period policy
- Set the minimum number of days for backup retention

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_rds_enforce_backup_retention_period_for_db_instances/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-rds](https://hub.guardrails.turbot.com/mods/aws/mods/aws-rds)

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
cd guardrails-samples/policy_packs/aws/rds/enforce_backup_retention_period_for_db_instances
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


If you prefer to use Terraform to attach the policy pack for testing or automation, you can uncomment and use the `turbot_policy_pack_attachment` resource block in `main.tf`:

```hcl
 # resource "turbot_policy_pack_attachment" "test" {
 #   count       = var.test_resource_id != "" ? 1 : 0
 #   policy_pack = turbot_policy_pack.enforce_backup_retention_period_for_db_instances.id
 #   resource    = var.test_resource_id
 # }
```

Example command to execute:

```
terraform plan -var="test_resource_id=358605999151417"
terraform apply -var="test_resource_id=358605999151417"
terraform destroy -var="test_resource_id=358605999151417"
```
 **NOTE** This is commented out by default and can be used based in need.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
# AWS > RDS > DB Instance > Backup Retention Period
resource "turbot_policy_setting" "backup_retention_period" {
  resource = turbot_policy_pack.enforce_backup_retention_period_for_db_instances.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceBackupRetentionPeriod"
  value    = "Check: Backup retention period"
  # value    = "Enforce: Backup retention period"
}

# AWS > RDS > DB Instance > Backup Retention Period > Days
resource "turbot_policy_setting" "backup_retention_days" {
  resource = turbot_policy_pack.enforce_backup_retention_period_for_db_instances.id
  type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceBackupRetentionPeriodDays"
  value    = 7
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```

## References

- [AWS > RDS > DB Instance > Backup Retention Period Policy Spec](https://hub.guardrails.turbot.com/mods/aws/policies/aws-rds/dbInstanceBackupRetentionPeriod#policy-specification)