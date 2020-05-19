# AWS Systems Manager / Package Installer

## Use cases
The business owner of the AWS platform wants to install packages on instances through 
[AWS Systems Manager](https://docs.aws.amazon.com/systems-manager). Instances may have access to internet or not

## Implementation Details
This stack defines a set of [AWS Systems Manager](https://docs.aws.amazon.com/systems-manager) documents designed to 
allow package installation on instances (with or without access to internet).
This terraform configuration sets SSM document definitions on `AWS > SSM > Stack > Source` policy, which will create 
the documents on AWS account region, defined on [default.tfvars](default.tfvars) file

## Pre-requisites

To create the documents for this stack, you must have:
- Locally
  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - Credentials Configured to connect to your Turbot workspace
- On AWS Account
  - S3 Bucket to store packages
  - A role for SSM document execution with the following permissions
      - ssm
        - DescribeInstanceInformation
        - ListCommandInvocations
        - ListCommands
        - SendCommand
      - s3
        - PutObject
  - A role for the instance with the following policies
    - AmazonSSMManagedInstanceCore
    - AmazonS3ReadOnlyAccess

## Running the Example

Set values for variables on [default.tfvars](default.tfvars) file

To run the Template:
- Navigate to the directory on the command line `cd aws_ssm_package_installer`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

## Using the SSM documents
To install a package on a instance with outbound access to internet
- Run the document `Turbot-LinuxPackageInstaller-PublicNetwork`
  - Inform the package name to be installed
  - Choose target instances

To install a package on a instance with no access to internet
- Run the document `Turbot-LinuxPackageInstaller-PrivateNetwork`
  - Inform the URL of the package to be installed
  - Inform the S3 bucket where package will be stored and available to instances
  > This document targets instance with `turbot:InventoryCollection` tag `true`

## Backlog

- Currently only Ubuntu is supported. Add support to more Linux flavours and Windows
- Handle package dependencies when installing through S3
- Test edge cases
