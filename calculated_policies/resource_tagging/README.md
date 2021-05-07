# Resource Details Tagging

## Use case

Tagging is a consistent governance control across AWS, Azure and GCP resources. Resource details are stored in the CMDB and updated in real-time as configurations change.  Any resource details from the CMDB can be leveraged in a Turbot policy, including your tagging templates for your resources.  The example below is the same for any resource that can be tagged or labeled in a cloud provider.  With calculated policies we can enable this automation by setting the `{Cloud Provider} > {Service} > {Resource} > Tags > Template` policy.  Lets take an AWS EC2 Instance as an example; there are over 100 fields to bring into your tag template; e.g. https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/definitions/instance


## Implementation details

This Terraform template creates a smart folder and applies the calculated policy on the policy:

- `AWS > EC2 > Instance > Tags`
- `AWS > EC2 > Instance > Tags > Template`

The Calculated policy creates a tag template.
The template shows creating static and dynamic values.
It also shows how to control the values of tags on a bucket.

### Template input (GraphQL)

The template input to a calculated policy is a GraphQL query.

In this case the query selects various metadata about the bucket.

```graphql
{
    instance {
    ImageId
      InstanceId
      InstanceType
      PrivateIpAddress
      SubnetId
      VpcId
    }
}
```

### Template (Nunjucks)

```nunjucks
"Instance ID": "{{ $.instance.InstanceId }}"
Type: "{{ $.instance.InstanceType }}"
Image: "{{ $.instance.ImageId }}"
VPC: "{{ $.instance.VpcId }}"
Subnet: "{{ $.instance.SubnetId }}"
"IP Address": "{{ $.instance.PrivateIpAddress }}"
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 13+
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

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
