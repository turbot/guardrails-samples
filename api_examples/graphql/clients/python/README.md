## Python examples

Provides Python scripts that show how an end user can run controls, query data and make decisions based on resource data
which is returned from Turbot.

### Available scripts

| Title | Description |
| ----- | ----------- |
| [AWS Account Import](./aws_import/README.md) | Import an existing AWS account into Turbot. |
| [Get notifications by notification class](./get-notifications-by-class/README.md) | Return a filtered collection of notifications for end user provided notification classes to filter results. |
| [Get notifications by notification type](./get-notifications-by-type/README.md) | Return a filtered collection of notifications for end user provided notification types to filter results. |
| [Get notifications for resource](./get-notifications-for-resource/README.md) | Return notifications for an end user specified to filter results. |
| [Run controls](./run_controls/README.md) | Runs all controls that match the end user provided filter. |
| [Run controls in batches](./run_controls_batches/README.md) | Runs all controls in batches with a cool down period that match the end user provided filter. |
| [Run policies](./run_policies/README.md) | Runs all policies that match the end user provided filter. |
| [Run policies in batches](./run_policies_batches/README.md) | Runs all policies in batches with a cool down period that match the end user provided filter. |

## Prerequisites

To run the scripts, you must have:

- [Python 3.\*.\*](https://www.python.org/downloads/)
- [Pip](https://pip.pypa.io/en/stable/installing/)

### Configuring credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Executing the script

To run a the python script:

1. Install and configure the [pre-requisites](#pre-requisites)
1. Using the command line, navigate to the directory for the Python script
1. Create and activate the Python virtual environment
1. Install dependencies
1. Run the Python script using the command line
1. Deactivate the Python virtual environment

## Contributing

Section to be completed at a later stage