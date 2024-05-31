# AWS Default VPC Deletion - cleaning up unused default networking configurations

## Use case

For any new AWS account, default VPCs and default subnets are automatically created per region.  Intention is for getting started quickly; launching a new public instance in any region you may want to use.  That is great for a brand new AWS user getting started, however it a nuisance to manage once you are past your first ever AWS account. Since Turbot customers have 10s to 1000s of accounts with global infrastructure associated with their network, default VPCs add complexity as they are automatically created in every region, have overlapping CIDR ranges, and assume public routing.  Having default VPCs lying around allows for developers to accidentally deploy public resources globally adding risk of exposure and operational overhead to manage. Taking action quickly will avoid more pain later trying to delete when resources are running those VPCs.


## Implementation details

This Terraform template creates a smart folder and applies the following policy settings:

- `AWS > VPC > Default VPC > Approved`
- `AWS > VPC > Default VPC > Approved > Usage`

## Prerequisites

To run this example, you must install:

- [Terraform](https://www.terraform.io) Version 12+
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot Workspace

### Configuring credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- smart_folder_title (Optional)
- smart_folder_description (Optional)
- smart_folder_parent_resource (Optional)

Open the file [variables.tf](variables.tf) for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform apply -var-file=default.tfvars`

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`