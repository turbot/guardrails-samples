resource "turbot_policy_pack" "main" {
  title       = "Enforce EBS Volume Backups"
  description = "Mitigate the risk of lost data by using the AWS Backup service to make backups of EBS volumes"
  akas        = ["aws_backup_enforce_ebs_volume_backups"]
}
