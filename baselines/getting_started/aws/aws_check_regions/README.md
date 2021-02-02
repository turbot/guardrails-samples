# Baseline - AWS Check Regions

This baseline will allow you to discover resources in multiple regions and not approve usage of resource that are not
in an allowable region.

This baseline is only effective when the account regions policies have multiple regions set.

The account approved regions `AWS > Account > Approved Regions [Default]` policy contains a list of AWS regions in which
cloud resources are approved for use.

The policy `AWS > Account > Regions` contains a list of AWS region where a resource can be recorded (discovered).

If the [AWS Baseline](../aws_baseline/) has only one region enabled then the approving regions policy will not be
effective as Turbot will only discovers resources for that one region.

This baseline needs to be considered carefully in conjunction with the `AWS > Account > Regions` policy set in
the [AWS Baseline](../aws_baseline/).

Turbot also supports AWS Lockdown / Boundary policies to limit access to regions which are not part of this baseline.

The advantage of setting up of each baseline in their own Smart Folder prevents conflicting with the policy settings
created by other baselines.

This baseline will not attach to a resource and will need to be done manually using the Turbot UI.

## Requirements

- Terraform v0.13 or greater installed
- Valid Turbot configuration credentials

For further information on configuring Turbot credentials can be found [here](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials).

## Applying baseline

The baseline is defined by a set of files which together define the configuration of the baseline.

### Deploying demo example

The demo baseline expects that the following mods are installed:

- aws_lambda
- aws_ec2
- aws_s3
- aws-vpc-core
- aws-vpc-connect
- aws-vpc-internet
- aws-vpc-security

To run the baseline:

1. Navigate to the folder of the baseline
2. Initialise Terraform
3. Apply the baseline using the demo input variable file [demo.tfvars](demo.tfvars)

On the terminal this will look like:

```shell
cd <baseline_folder>
terraform init
terraform apply --var-file demo.tfvars
```

### Input variable files

Input variable files allow for the user to configure configuration definitions for multiple environments in different files.

It will be used to define which parts of the baseline to apply and which to ignore.

The variables that can be overwritten by the input variable files are defined in the [variables.tf](variables.tf) file.

This baseline comes with an example input variable file called [demo.tfvars](demo.tfvars).

Further details found in official [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html).

### Initialise baseline

If not previously run, initialise Terraform to get all necessary providers for the baseline.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform init
   ```

### Apply baseline without input variable file

The baseline can be applied without an input variable file.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform apply
   ```

This may prompt the user applying the baseline to enter values for variables that do not have default values.

### Apply baseline using input variable files

If seeking to apply the baseline using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform apply --var-file=demo.tfvars
   ```

### Destroy baseline without input variable file

If seeking to apply the baseline without using an input variable file.

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform destroy
   ```

### Destroy using input variable files

If seeking to destoy the baseline configuration using an input variable file such as [demo.tfvars](demo.tfvars).

1. Navigate to the folder containing the baseline configuration.
2. Run the command:

   ```shell
   terraform destroy --var-file=demo.tfvars
   ```

## Commenting strategy

All Turbot policies used by the baselines will have a link to the official Turbot Mods documentation.

Opening the links will give you further details about:

- The purpose of the policy
- Policy URI name
- Parent information
- Category information
- Target information
- All valid values
