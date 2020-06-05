## Calculated Policies

Provides templates for implementing calculated policies. 

Calculated policies allow Turbot administrators to modify or extend the default behavior and logic that Turbot uses to evaluate controls.

The calculated policy examples are implemented with [Terraform](https://www.terraform.io) allowing you to manage and 
provision Turbot with a repeatable, idempotent, versioned infrastructure-as-code approach.

### Current Calculated Policies

| Path | Description |
| ---- | ----------- |
|<img width=200/>|<img width=500/>|
| [aws_ec2_instance_age](./aws_ec2_instance_age/README.md) | AWS EC2 - Set maximum age of specially tagged EC2 instances |
| [aws_ec2_instance_approved_usage_approved_account_ami](./aws_ec2_instance_approved_usage_approved_account_ami/README.md) | AWS EC2 Instance - Restrict Instance images to trusted AWS accounts AMIs |
| [aws_ec2_instance_approved_usage_local_ami](./aws_ec2_instance_approved_usage_local_ami/README.md) | AWS EC2 Instance - Restrict Instance Image to local AMI |
| [aws_ec2_instance_approved_usage_trusted_ami](./aws_ec2_instance_approved_usage_trusted_ami/README.md) | AWS EC2 Instance - Restrict Instance Images to trusted AMI |
| [aws_ec2_public_subnet](./aws_ec2_public_subnet/README.md) | AWS EC2 - Instance Not Approved if Public Subnet |
| [aws_guardduty_detector_approved_usage](./aws_guardduty_detector_approved_usage/README.md) | AWS GuardDuty - Restrict detector membership to a given master account |
| [aws_lambda_in_vpc](./aws_lambda_in_vpc/README.md) | AWS Lambda - Approve a Lambda function only if it is within a particular VPC |
| [aws_lambda_not_approved_cross_account_access](./aws_lambda_not_approved_cross_account_access/README.md) | AWS Lambda - Alarm if function policy has cross-account access |
| [aws_rds_db_cluster_snapshot_cross_account_access](./aws_rds_db_cluster_snapshot_cross_account_access/README.md) | AWS RDS DB Cluster - Restrict Cross Account Snapshots by user defined Whitelist |
| [aws_redshift_restrict_cross_account_snapshot_access](./aws_redshift_restrict_cross_account_snapshot_access/README.md) | AWS RedShift - Restrict cross-account access to Redshift manual snapshots |
| [aws_s3_approved_static_website_hosting_requires_cloud_front](./aws_s3_approved_static_website_hosting_requires_cloud_front/README.md) | AWS S3 - Approved Usage - Enforce static website hosting is associated with CloudFront |
| [aws_s3_bucket_approved_usage_cross_account_replication](./aws_s3_bucket_approved_usage_cross_account_replication/README.md) | AWS S3 Bucket - Restrict Cross Account Replication by user defined Whitelist |
| [aws_s3_bucket_approved_usage_name_dns_compliant](./aws_s3_bucket_approved_usage_name_dns_compliant/README.md) | AWS S3 Bucket - restrict name to DNS compliant. |
| [aws_s3_bucket_tagging_template](./aws_s3_bucket_tagging_template/README.md) | AWS S3 - Set default tags on buckets with dynamic metadata |
| [aws_sqs_approved](./aws_sqs_approved/README.md) | AWS SQS Queue Approved Usage - Alarm if SQS policy violates org restrictions |
| [azure_load_balancer_prohibited_ports](./azure_load_balancer_prohibited_ports/README.md) | Azure Networking - Prevent unapproved network configuration for load balancers |
| [multi_cloud_storage_cost_savings](./multi_cloud_storage_cost_savings/README.md) | Multi-Cloud Storage - Set least expensive storage options for development environments |

### Current Calculated Policies Details

---

**Title:** AWS EC2 - Set maximum age of specially tagged EC2 instances

**Example**: [aws_ec2_instance_age](./aws_ec2_instance_age/README.md)

**Details**
This script provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS > EC2 > Instance > Active > Age` policy.  
The Calculated policy sets the active age threshold to 30 days when a tag is present on the instance matching 
{Environment:=Lab} and to skip if it is not present or set to an alternate value.

---

**Title:** AWS EC2 Instance - Restrict Instance images to trusted AWS accounts AMIs

**Example**: [aws_ec2_instance_approved_usage_approved_account_ami](./aws_ec2_instance_approved_usage_approved_account_ami/README.md)

**Details**
Calculated policy for policy `AWS > EC2 > Instance > Approved > Usage`.
If a EC2 Instance Image is not owned by an account in the approved accounts list, then the approved usage
policy will be set to `Not approved` otherwise it will be set to `Approved`.

---

**Title:** AWS EC2 Instance - Restrict Instance Image to local AMI

**Example**: [aws_ec2_instance_approved_usage_local_ami](./aws_ec2_instance_approved_usage_local_ami/README.md)

**Details**
Calculated policy for policy `AWS > EC2 > Instance > Approved > Usage`.
Approval policy that will limit running EC2 Instances to only use local EC2 Instance Images.
If an EC2 Instance Image is not owned by the account that the Instance is running on, then the approved usage
policy will be set to `Not approved` otherwise it will be set to `Approved`.

---

**Title:** AWS EC2 Instance - Restrict Instance Images to trusted AMI

**Example**: [aws_ec2_instance_approved_usage_trusted_ami](./aws_ec2_instance_approved_usage_trusted_ami/README.md)

**Details**
Calculated policy for policy `AWS > EC2 > Instance > Approved > Usage`.
If a EC2 Instance Image is not in the trusted AMI list, then the approved usage
policy will be set to `Not approved` otherwise it will be set to `Approved`.

---

**Title:** AWS EC2 - Instance Not Approved if Public Subnet

**Example**: [aws_ec2_public_subnet](./aws_ec2_public_subnet/README.md)

**Details**
This script provides a Terraform configuration for creating a smart folder and applying a calculated policy using 
`AWS > EC2 > Instance > Approved > Usage` policy and then setting `AWS > EC2 > Instance > Approved` to check.

---

**Title:** AWS GuardDuty - Restrict detector membership to a given master account

**Example**: [aws_guardduty_detector_approved_usage](./aws_guardduty_detector_approved_usage/README.md)

**Details**
Calculated policy for policy `AWS > GuardDuty > Detector > Approved > Usage`.
If a Detector is the master or member of a given master account then the approved usage policy will be set
to `Approved` otherwise it will be set to `Not approved`.

---

**Title:** AWS Lambda - Approve a Lambda function only if it is within a particular VPC

**Example**: [aws_lambda_in_vpc](./aws_lambda_in_vpc/README.md)

**Details**
This script provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS > Lambda > Function > Approved > Usage` policy.  
The Calculated policy checks the Lambda metadata for existence of the attribute VpcConfig and can be expanded to check
for a specific VPC Id or Subnet Ids.

---

**Title:** AWS Lambda - Alarm if function policy has cross-account access

**Example**: [aws_lambda_not_approved_cross_account_access](./aws_lambda_not_approved_cross_account_access/README.md)

**Details**
Calculated policy for policy `AWS > Lambda > Function > Approved > Usage`.
If a function policy has cross-account access then the approved usage policy will be set to `Not approved` otherwise
it will be set to `Approved`.

---

**Title:** AWS RDS DB Cluster - Restrict Cross Account Snapshots by user defined Whitelist

**Example**: [aws_rds_db_cluster_snapshot_cross_account_access](./aws_rds_db_cluster_snapshot_cross_account_access/README.md)

**Details**
Use the AWS > RDS > DB Cluster Snapshot [Manual] > Approved > Usage policy.
Calculated policy for policy `AWS > RDS > DB Cluster Snapshot [Manual] > Approved > Usage` policy.
If the account that the snapshot is shared with, given by the property `DBClusterSnapshotAttributes.AttributeValues`

---

**Title:** AWS RedShift - Restrict cross-account access to Redshift manual snapshots

**Example**: [aws_redshift_restrict_cross_account_snapshot_access](./aws_redshift_restrict_cross_account_snapshot_access/README.md)

**Details**
Calculated policy for policy `AWS > Redshift > Manual Cluster Snapshot > Approved > Usage`.
If a manual snapshot is configured to allow access from external accounts restore access then the approved usage 
policy will be set to `Not approved` otherwise it will be set to `Approved`.

---

**Title:** AWS S3 - Approved Usage - Enforce static website hosting is associated with CloudFront

**Example**: [aws_s3_approved_static_website_hosting_requires_cloud_front](./aws_s3_approved_static_website_hosting_requires_cloud_front/README.md)

**Details**
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS> S3> Bucket> Tags> Template`.
The Calculated policy creates a tag template.
The template shows creating static and dynamic values.
It also shows how to control the values of tags on a bucket.

---

**Title:** AWS S3 Bucket - Restrict Cross Account Replication by user defined Whitelist

**Example**: [aws_s3_bucket_approved_usage_cross_account_replication](./aws_s3_bucket_approved_usage_cross_account_replication/README.md)

**Details**
Use the AWS > S3 > Bucket > Approved > Usage policy.
Calculated policy for policy `AWS > S3 > Bucket > Approved > Usage` policy.
If the account that the replication is shared with, given by the property `Replication.Rules[].Destination.Account`
is not whitelisted, then the policy will be set to `Not approved` otherwise it will be set to `Approved`.

---

**Title:** AWS S3 Bucket - restrict name to DNS compliant.

**Example**: [aws_s3_bucket_approved_usage_name_dns_compliant](./aws_s3_bucket_approved_usage_name_dns_compliant/README.md)

**Details**
Calculated policy for policy `AWS > S3 > Bucket > Approved > Usage`.
If a S3 Bucket name is not DNS compliant, then the approved usage policy will be set to `Not approved` otherwise
it will be set to `Approved`.

---

**Title:** AWS S3 - Set default tags on buckets with dynamic metadata

**Example**: [aws_s3_bucket_tagging_template](./aws_s3_bucket_tagging_template/README.md)

**Details**
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS> S3> Bucket> Tags> Template`.
The Calculated policy creates a tag template.
The template shows creating static and dynamic values.
It also shows how to control the values of tags on a bucket.

---

**Title:** AWS SQS Queue Approved Usage - Alarm if SQS policy violates org restrictions

**Example**: [aws_sqs_approved](./aws_sqs_approved/README.md)

**Details**
Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS > SQS > Queue > Approved > Usage` policy.
The Calculated policy creates a template that will alarm if a queue policy contains "Action: SQS:*".

---

**Title:** Azure Networking - Prevent unapproved network configuration for load balancers

**Example**: [azure_load_balancer_prohibited_ports](./azure_load_balancer_prohibited_ports/README.md)

**Details**
This Terraform configuration for creating a smart folder and applying the 
`Azure > Load Balancer > Load Balancer > Approved` to "Check: Approved" and a calculated policy on 
`Azure > Load Balancer > Load Balancer > Approved > Usage`.
The Calculated policy sets the value to "Unapproved" when one of the specified ports are present in the NAT or Load 
Balancer front end or back end rules and sets the value "Approved" otherwise.

---

**Title:** Multi-Cloud Storage - Set least expensive storage options for development environments

**Example**: [multi_cloud_storage_cost_savings](./multi_cloud_storage_cost_savings/README.md)

**Details**
This Terraform template creates a smart folder and applies a calculated policies on the policies:

- `Azure > Storage > Storage Account > Access Tier`
- `AWS > S3 > Bucket > Versioning`

For Azure, the calculated policy sets the storage tier to "Cool" when an Azure label matching {Environment:=Dev} is 
present on a storage account resource

For AWS, the calculated policy disables S3 versioning when an AWS tag matching {Environment:=Dev} is present on an 
S3 bucket resource.

---
