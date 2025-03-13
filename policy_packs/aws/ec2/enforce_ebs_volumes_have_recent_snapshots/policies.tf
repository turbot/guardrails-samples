# AWS > Backup > Backup Plan > Configured
resource "turbot_policy_setting" "backup_plan_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-backup#/policy/types/backupPlanConfigured"
  value    = "Check: Per Configured > Source (unless claimed by a stack)"
  # value    = "Enforce: Per Configured > Source (unless claimed by a stack)"
}

# AWS > Backup > Backup Plan > Configured > Source
resource "turbot_policy_setting" "backup_plan_configured_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-backup#/policy/types/backupPlanConfiguredSource"
  # Define the Terraform configuration to enable AWS Backup for EBS volumes
  value    = <<EOT
# This template configures AWS Backup for EBS volumes with daily backups
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Create a backup vault
resource "aws_backup_vault" "ebs_backup_vault" {
  name = "ebs-backup-vault"
}

# Create a backup plan
resource "aws_backup_plan" "ebs_backup_plan" {
  name = "ebs-volumes-backup-plan"

  rule {
    rule_name         = "daily-ebs-volume-backups"
    target_vault_name = aws_backup_vault.ebs_backup_vault.name
    schedule          = "cron(0 1 * * ? *)" # Run daily at 1:00 AM UTC
    
    lifecycle {
      delete_after = 35 # Keep backups for 35 days
    }
  }

  # Optional advanced backup settings for EBS volumes
  advanced_backup_setting {
    resource_type = "EC2"
    backup_options = {
      WindowsVSS = "enabled"
    }
  }
}

# Create a selection for all EBS volumes
resource "aws_backup_selection" "ebs_volumes_selection" {
  name          = "ebs-volumes-backup-selection"
  iam_role_arn  = aws_iam_role.backup_role.arn
  plan_id       = aws_backup_plan.ebs_backup_plan.id
  
  # Select all EBS volumes
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}

# Create an IAM role for AWS Backup
resource "aws_iam_role" "backup_role" {
  name = "aws-backup-role"
  
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

# Attach the AWS Backup service role policy
resource "aws_iam_role_policy_attachment" "backup_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_role.name
}

# Attach the AWS Backup restore role policy
resource "aws_iam_role_policy_attachment" "restore_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  role       = aws_iam_role.backup_role.name
}
EOT
}
