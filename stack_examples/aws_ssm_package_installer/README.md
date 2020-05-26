# AWS SSM Package Installer

## Use case

The business owner of the AWS platform wants to install packages on instances using [AWS Systems Manager](https://docs.aws.amazon.com/systems-manager). 
Instances may or may not have direct access to original package source. 

## Pre-requisites

Below are the software requirements to create the documents for this stack:
  - [Terraform](https://www.terraform.io) Version 12
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  - Credentials Configured to connect to your Turbot workspace

AWS Configuration to run stack control:
  - S3 Bucket to store packages
  - A role for SSM document execution with the following configured permissions:
      - SSM
        - DescribeInstanceInformation
        - ListCommandInvocations
        - ListCommands
        - SendCommand
      - S3
        - PutObject
  - A role for the instance with the following configured polices:
    - AmazonSSMManagedInstanceCore
    - AmazonS3ReadOnlyAccess

## Implementation Details

This stack defines a set of [AWS Systems Manager](https://docs.aws.amazon.com/systems-manager) documents designed to 
allow package installation on instances with or without direct access to original package source.

This terraform configuration sets SSM document definitions on `AWS > SSM > Stack > Source` policy, which will create 
the documents on AWS account region defined by the [default.tfvars](default.tfvars) file.

On successful execution of the stack control, three documents will be created:
  - Turbot-LinuxPackageInstaller-PublicNetwork
  - Turbot-LinuxPackageInstaller-PrivateNetwork
  - Turbot-LinuxS3PackageInstaller

## Running the Example

Set values for variables on [default.tfvars](default.tfvars) file.

To run the Template:
1. Navigate to the directory on the command line `cd aws_ssm_package_installer`
2. Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
3. Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

## Using the SSM documents

There are two entry point types:
  - Turbot-LinuxPackageInstaller-PublicNetwork
  - Turbot-LinuxPackageInstaller-PrivateNetwork

### Turbot-LinuxPackageInstaller-PublicNetwork

Use this entry point type when there is direct access to the package source.
Using this method, all that is required to the URL of the package to install.

### Turbot-LinuxPackageInstaller-PrivateNetwork

Use this entry point type when there is no direct access to the package source.
Using this method, it is required that the URL of the package to install and a valid S3 bucket which be used to cache the package.

### Turbot-LinuxS3PackageInstaller

This document should never be directly run but is a helper document to install the package.

## Current limitations

- Currently only Ubuntu is supported. Add support to more Linux flavours and Windows
- Handle package dependencies when installing through S3
- Test edge cases
