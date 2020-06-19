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
| [aws_redshift_cluster_require_ssl](./aws_redshift_cluster_require_ssl/README.md) | AWS RedShift | Approve cluster if encryption in transit is required |
| [aws_redshift_restrict_cross_account_snapshot_access](./aws_redshift_restrict_cross_account_snapshot_access/README.md) | AWS RedShift | Restrict RedShift Manual Cluster access to cross account Manual Clusters Snapshots |
| [aws_s3_approved_static_website_hosting_requires_cloud_front](./aws_s3_approved_static_website_hosting_requires_cloud_front/README.md) | AWS S3 Bucket | Enforce static website hosting is associated with CloudFront |
| [aws_s3_bucket_approved_usage_cross_account_replication](./aws_s3_bucket_approved_usage_cross_account_replication/README.md) | AWS S3 Bucket | Restrict Cross Account Replication by user defined Whitelist |
| [aws_s3_bucket_approved_usage_name_dns_compliant](./aws_s3_bucket_approved_usage_name_dns_compliant/README.md) | AWS S3 Bucket | Restrict name that are not DNS compliant |
| [aws_s3_bucket_match_tags_on_bucket_and_cmk](./aws_s3_bucket_match_tags_on_bucket_and_cmk/README.md) | AWS S3 | Match tags on Bucket and corresponding Key Management Service. |
| [aws_s3_bucket_tagging_template](./aws_s3_bucket_tagging_template/README.md) | AWS S3 | Set default tags on buckets with dynamic metadata |
| [aws_sqs_approved](./aws_sqs_approved/README.md) | AWS SQS Queue | Alarm if SQS policy violates org restrictions |
| [azure_load_balancer_prohibited_ports](./azure_load_balancer_prohibited_ports/README.md) | Azure Networking | Prevent unapproved network configuration for load balancers |
| [azure_storage_container_approved_usage_not_public](./azure_storage_container_approved_usage_not_public/README.md) | Azure Storage | Container approved if not public |
| [multi_cloud_storage_cost_savings](./multi_cloud_storage_cost_savings/README.md) | Multi-Cloud Storage | Set least expensive storage options for development environments |

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running a Calculated Policies

To run a Calculated Policies:

1. Install and configure the [pre-requisites](#pre-requisites)
1. Using the command line, navigate to the directory for the Calculated Policies
1. Run `terraform init` to initialize terraform in the directory
1. Edit any variables in the .tf file that you wish to change, or override with [environment variables](https://www.terraform.io/docs/commands/environment-variables.html) or [variable files](https://www.terraform.io/docs/configuration/variables.html#variable-definitions-tfvars-files)
1. Run `terraform plan -var-file="<fileName>.tfvars"` and inspect the changes
1. Run `terraform apply -var-file="<fileName>.tfvars"` to apply the configuration

## Contributing

### Structure

Calculated Polices are implemented as independently deployable terraform configurations and are organised as 
sub-directories within this repository.

Commonly changed parameters are implemented using variables. 
Most variables have default values, but these values assigned to these variables can be overwritten by the end user. 

Each Calculated Policy folder contains:

- `variables.tf` containing the variable definitions

- `main.tf` containing the terraform resources that creates the objects

- `default.tfvars` containing the defaults for the variables

- `README.md` detailing the Calculated Policy and usage information

```
Baseline
.
├── README.md
├── main.tf
├── variables.tf
└── default.tfvar
```

### Style Guide

Our Calculate Policies adopts styling conventions provided by [Terraform](https://www.terraform.io/docs/configuration/style.html) 
like:

- Align the equal to signs for arguments appearing on consecutive lines with values.
- Variables should use snake case: `this_is_an_example`
- Use empty lines to separate logical groups of arguments within a block.

To maintain consistency between files and modules, we recommend adopting the below added styling conventions:

- Include the variable definitions in the `variables.tf` file
- Resources in the `main.tf` file, 
- Values to output in `outputs.tf` file.
- For `turbot_policy_setting` and `turbot_policy_value` resources, include the policy type hierarchy in a comment 
  before the resource. For example:

  ```terraform
  # AWS > Account > Turbot IAM Role > External ID
  resource "turbot_policy_setting" "turbotIamRoleExternalId" {
    resource    = turbot_resource.account_resource.id
    type        = "tmod:@turbot/aws#/policy/types/turbotIamRoleExternalId"
    value       = var.turbot_external_id
  }
  ```

- Use a single hash for comments that refer only to a single resource, immediately before the resource, for example:

  ```terraform
  # 1.4 Ensure access keys are rotated every 90 days or less (Scored)
  # AWS > IAM > Access Key > Active > Age
  # Setting value to "Force inactive if age > 90" days to meet remediation
  resource "turbot_policy_setting" "AWS_IAM_AccessKey_Active_Age" {
    resource    = var.target_resource
    type        = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
    value       = "Force inactive if age > 90 days"
  }
  ```

- Use 4 hashes for comments that describe a group of resources, or general behavior:

  ```terraform
  #### Set the credentials (Role, external id) for the account via Turbot policies
  ```

- All variables should have a description, and as a result should not require individual comments
- Most variables should have a reasonable default
- Calculated Policies should be always children of a Smart Folder resource
- The resource to associate with the Smart Folder should use a variable for the target resource

  ```terraform
  variable "target_resource" {
    description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
    type        = string
  }
  ```

  - it should be called `target_resource`
  - it should have no default value in `variables.tfvars`

  It should have a comment that states that it may be changes or overridden in the `default.tfvars` 

  ```terraform
  # Required - Target resource to attach to smart folder
  target_resource = "<resource_id_or_aka>"
  # Examples for target_resource
  # target_resource = "tmod:@turbot/turbot#/"
  # target_resource = "191238958290468"
  ```

- The parent resource for the Smart Folder should use a variable for the target resource

  ```terraform
  variable "smart_folder_parent_resource" {
    description = "Enter the resource ID or AKA for the parent of the smart folder"
    type        = string
    default     = "tmod:@turbot/turbot#/"
  }
  ```

  - it should be called `smart_folder_parent_resource`
  - it should have the default value in `tmod:@turbot/turbot#/`

  It should have a comment that states that it may be changes or overridden in the `default.tfvars`.

  ```terraform
  # Optional - Default value: tmod:@turbot/turbot#/
  # smart_folder_parent_resource = "<resource_id_or_aka>"
  ```   