# Example Folder Hierarchy

This Terraform package demonstrates an example folder hierarchy that might exist in a real environment.

A total of seven folders are created:

* ACME
    * Prod
        * Prod IT
        * Prod Apps
    * Dev
        * Dev IT
        * Dev Apps

## Pre-requisites

To run the example folder hierarchy, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) configured to connect to your Turbot workspace

## Running the Baseline

To execute the baseline, simply navigate to the example_folder_hierarchy folder using your command line tool of choice, and execute!

To run the mod install baseline:

- Go to the directory using the command line tool of choice `cd example_folder_hierarchy`.
- Update `default.tfvars` with appropriate values. If you are simply looking to test, these values can be left default.
- Run `terraform plan -var-file=default.tfvars` to review the plan for aws permissions.
- Run `terraform apply -var-file=default.tfvars` to apply the changes.
