# Turbot AWS Event Handlers

Provides a Terraform configuration for creating a smart folder and sets a policy to enable Turbot AWS Event Handlers. Our [AWS Event Handlers](https://turbot.com/v5/docs/integrations/aws/event-handlers) documentation has more information regarding pre-requisites and configuration options.


## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) configured to connect to your Turbot workspace

## Running the Example

To run the Turbot AWS Event Handlers example:
- Navigate to the directory on the command line `turbot_aws_event_handlers`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings