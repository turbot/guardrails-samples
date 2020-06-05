## Calculated Policies

Provides templates for implementing calculated policies. 

Calculated policies allow Turbot administrators to modify or extend the default behavior and logic that Turbot uses to evaluate controls.

The calculated policy examples are implemented with [Terraform](https://www.terraform.io) allowing you to manage and 
provision Turbot with a repeatable, idempotent, versioned infrastructure-as-code approach.

### Current Calculated Policies

| Path | Resource | Description |
| ---- | -------- | ----------- |
| [aws_ec2_instance_age](./aws_ec2_instance_age/README.md) | AWS EC2 | Set maximum age of specially tagged EC2 instances |
| [aws_ec2_instance_approved_usage_approved_account_ami](./aws_ec2_instance_approved_usage_approved_account_ami/README.md) | AWS EC2 | Restrict Instance images to trusted AWS accounts AMIs |
| [aws_ec2_instance_approved_usage_local_ami](./aws_ec2_instance_approved_usage_local_ami/README.md) | AWS EC2 | Restrict Instance Image to local AMI |
| [aws_ec2_instance_approved_usage_trusted_ami](./aws_ec2_instance_approved_usage_trusted_ami/README.md) | AWS EC2 | Restrict Instance Images to trusted AMI |
| [aws_ec2_public_subnet](./aws_ec2_public_subnet/README.md) | AWS EC2 | Instance Not Approved if Public Subnet |
| [aws_guardduty_detector_approved_usage](./aws_guardduty_detector_approved_usage/README.md) | AWS GuardDuty | Restrict detector membership to a given master account |
| [aws_lambda_in_vpc](./aws_lambda_in_vpc/README.md) | AWS Lambda | Approve a Lambda function only if it is within a particular VPC |
| [aws_lambda_not_approved_cross_account_access](./aws_lambda_not_approved_cross_account_access/README.md) | AWS Lambda | Alarm if function policy has cross-account access |
| [aws_rds_db_cluster_snapshot_cross_account_access](./aws_rds_db_cluster_snapshot_cross_account_access/README.md) | AWS RDS | Restrict RDS DB Clusters access to cross account Manual DB Clusters Snapshots |
| [aws_redshift_restrict_cross_account_snapshot_access](./aws_redshift_restrict_cross_account_snapshot_access/README.md) | AWS RedShift | Restrict RedShift Manual Cluster access to cross account Manual Clusters Snapshots |
| [aws_s3_approved_static_website_hosting_requires_cloud_front](./aws_s3_approved_static_website_hosting_requires_cloud_front/README.md) | AWS S3 Bucket | Enforce static website hosting is associated with CloudFront |
| [aws_s3_bucket_approved_usage_cross_account_replication](./aws_s3_bucket_approved_usage_cross_account_replication/README.md) | AWS S3 Bucket | Restrict Cross Account Replication by user defined Whitelist |
| [aws_s3_bucket_approved_usage_name_dns_compliant](./aws_s3_bucket_approved_usage_name_dns_compliant/README.md) | AWS S3 Bucket | Restrict name that are not DNS compliant |
| [aws_s3_bucket_tagging_template](./aws_s3_bucket_tagging_template/README.md) | AWS S3 | Set default tags on buckets with dynamic metadata |
| [aws_sqs_approved](./aws_sqs_approved/README.md) | AWS SQS Queue | Alarm if SQS policy violates org restrictions |
| [azure_load_balancer_prohibited_ports](./azure_load_balancer_prohibited_ports/README.md) | Azure Networking | Prevent unapproved network configuration for load balancers |
| [multi_cloud_storage_cost_savings](./multi_cloud_storage_cost_savings/README.md) | Multi-Cloud Storage | Set least expensive storage options for development environments |

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).
