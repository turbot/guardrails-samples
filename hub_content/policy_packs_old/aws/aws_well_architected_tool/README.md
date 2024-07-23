# AWS Well-Architected Tool - Automated answers to Well-Architected Framework questions

## Use case

The AWS Well-Architected Framework (WAF) is a fantastic tool for discussions about the various aspects of an application, roughly mapped to the five pillars: Cost, Operations, Reliability, Security and Performance. For the WAF Lens, Turbot provides policies to idempotently set the values for the various pillar questions. There are many questions and answers in WAF which can be time-consuming to answer. Some or many of these questions can be answered at an organizational level. The Turbot policies for WAF are intended to provide organizations with an ability to set these answers at scale. Engineers and architects can then focus on the most meaningful questions.

## Implementation details

These Terraform files create a smart folder then policies in that smart folder.

Be aware that Turbot's core capability is to compare a resource against a policy then take remediation actions as often as required. Consider the following situation: An organization set a WAF policy to "False". Some time later an engineer sets the value to "True" in the AWS console. Turbot will detect that difference then set the answer back to "False". Be careful when choosing which questions to automatically answer. It's extremely easy to frustrate the engineers who have to answer Workload questions.

The provided terraform is a complete list of all questions and answers in the Well-Architected Framework Lens. Get more details in the [Well-Architected Framework mod](https://turbot.com/v5/mods/turbot/aws-wellarchitected-framework/inspect) docs.

Be aware that any of the WAF questions and answers can be interpreted multiple ways.  They are intended to facilitate conversation and explore the many possible perspectives. If an organization chooses a specific interpretation, this should be documented.  Conversations are more useful when everyone talks about the same thing. 

In `default.tfvars`, all policies are set to `Skip`.  The policy values in  `turbot-default.tfvars` represent answers where Turbot could largely cover the question.  The Turbot-Default answers should  not be considered the final word on what Turbot can or cannot do. Depending on how the question's interpretation, Turbot may or may not be able to cover the question.  These are only a starting point.

### Pillar Questions

For the WAF questions, there's a number of policy values that follow the usual Turbot conventions for "Skip", "Check" and "
Enforce".

- "Skip",
- "Check: Choices based on sub policies",
- "Check: None of these",
- "Check: Question does not apply to this workload",
- "Enforce: Choices based on sub policies",
- "Enforce: None of these",
- "Enforce: Question does not apply to this workload"

### Pillar Answers

For the WAF answers, customers can assert a "True" or "False" value or just "Skip".

- "Skip"
- "True"
- "False"

## Prerequisites

To run these Terraform files, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)  (Installed automatically with `terraform init`.)
- Configured credentials to connect to your Turbot workspace
- Install the [Well-Architected mod](https://turbot.com/v5/mods/turbot/aws-wellarchitected/inspect)
- Install the [Well-Architected Framework mod](https://turbot.com/v5/mods/turbot/aws-wellarchitected-framework/inspect)

Note: The Well-Architected mod focuses on management of Workload resources.  The Well-Architected Framework mod deals exclusively with answering the Well-Architected Framework Lens.  Customers who wish to only manage or monitor Workloads should only install the Well-Architected mod.

### Configuring credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace. Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).


### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are matched to each WAF question and answer. They are too numerous to enumerate in this ReadMe. Open the file [variables.tf](variables.tf) for further details.

Customers who wish to write calculated policies should alter the provided Terraform to their needs.

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

