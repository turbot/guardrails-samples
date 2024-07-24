# AWS > Backup > Stack
resource "turbot_policy_setting" "aws_backup_stack" {
  resource = turbot_policy_pack.main.id
  type = "tmod:@turbot/aws-backup#/policy/types/backupStack"
  #   value    = "Check: Configured"
  value    = "Enforce: Configured"
}

# AWS > Backup > Stack > Source
resource "turbot_policy_setting" "aws_backup_stack_source" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-backup#/policy/types/backupStackSource"
  # value          = "[]"  # To decommission the backup vault, uncomment this line and comment out the template and template_input.
  template_input = <<-EOT
    {
      account {
        id: Id
      }
    }
  EOT
  template       = <<-EOT
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
    resource "aws_backup_selection" "ebs_resource_assignment" {
      iam_role_arn = "arn:aws:iam::{{ $.account.id }}:role/turbot/core/guardrails_backup_service_role"
      name         = "guardrails-ebs-resource-assignment"
      plan_id      = aws_backup_plan.guardrails_ebs_backups.id
      resources = ["arn:aws:ec2:*:*:volume/*"]
    }
  EOT
}

# AWS > Backup > Stack > Terraform Version
resource "turbot_policy_setting" "aws_backup_backup_stack_terraform_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-backup#/policy/types/backupStackTerraformVersion"
  value    = "0.15.*"
}


# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_iam_stack" {
  resource = turbot_policy_pack.main.id
  type = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  #   value    = "Check: Configured"
  value    = "Enforce: Configured"
}

# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_iam_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  # value = "[]"  # To decommission the iam role, uncomment this line and comment out the template and template_input.
  template_input = <<EOT
  {
    account {
      metadata
    }
  }
EOT
  template       = <<EOT
|
resource "aws_iam_role" "guardrails_backup_service_role" {
  name = "guardrails_backup_service_role"
  path = "/turbot/core/"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  ]
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    turbot_version = "v5"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}
EOT
}

resource "turbot_policy_setting" "aws_iam_iam_stack_terraform_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackTerraformVersion"
  value    = "0.15.*"
}