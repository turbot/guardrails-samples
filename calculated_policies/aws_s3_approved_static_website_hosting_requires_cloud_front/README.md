# AWS S3 Bucket - Enforce static website hosting is associated with CloudFront

## Use case

This control is specifically for the Static Website Buckets. 
End-users should not be able to directly access the S3 bucket endpoint.
A static hosted S3 bucket must be associated with a CloudFront distribution.
In addition, that CloudFront distribution needs to enforce that access to the website uses the protocol HTTPS 
only.

## Implementation Details

This Terraform template creates a smart folder and applies calculated policies on the policies:

- `AWS > Region > Bucket > Approved`
- `AWS > Region > Bucket > Approved > Usage`

Provides a Terraform configuration for creating a smart folder and applying a calculated policy on the 
`AWS> S3> Bucket> Tags> Template`.
The Calculated policy creates a tag template.
The template shows creating static and dynamic values.
It also shows how to control the values of tags on a bucket.

### Template Input (GraphQL)

The template input to a calculated policy is a GraphQL query.

The query below is a two fold query, which functions as a JOIN in SQL. 
Initially, get the name of the current S3 bucket. 
Using this bucket name, do a subsequent query to get the associated CloudFront distribution using the 
bucket name as a part of the lookup key.

```graphql
- | 
  {
    item: bucket {
      Name
    }
  }
- |
  {
    resources(filter: "$.DistributionConfig.Origins.Items.*.DomainName:'{{ $.item.Name }}.s3.amazonaws.com' resourceTypeId:tmod:@turbot/aws-cloudfront#/resource/types/cloudFront")
    {
      items {
        ViewerProtocolPolicy: get(path:"DistributionConfig.ViewerProtocolPolicy.ViewerProtocolPolicy")
        CacheBehaviorsItems: get(path:"DistributionConfig.CacheBehaviors.Items")
      }
    }
    item: bucket {
      Website: get(path:"Website")
    }
  }
```

### Template (Nunjucks)

Initially set the policy value to `Approved` to allow for normal S3 bucket usage. 
If the S3 bucket is configured as a static website then we need to do some additional checks.

The code checks to see that the default cache behaviour has a viewer protocol policy that is set to HTTPS usage and 
will not allow HTTP usage.
If not, then we set the policy to `Not approved`.

Then next section will check to see that the addition cache behaviour has a viewer protocol policy that is set to 
HTTPS usage and will not allow HTTP usage.
If not, then we set the policy to `Not approved`.

Otherwise the S3 bucket will be `Approved`.

```nunjucks
{#- Always approved if static website hosting is disabled -#}
{%- set policyValue = "Approved" -%}

{#- Is static website hosting is enabled -#}
{%- if $.item.Website -%}

  {%- for item in $.resources.items -%}

    {#- Check if the the default cache behaviour is not secure, if not then `Not approved`-#}
    {%- if item.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}
      {#- Unapproved if an associated CloudFront distribution is set to http -#}
      {%- set policyValue = "Not approved" -%}
    {%- else -%}

      {#- Check if the the other cache behaviour is not secure, if not then `Not approved`-#}
      {%- for behaviorsItem in item.CacheBehaviorsItems -%}
        {%- if behaviorsItem.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}
          {%- set policyValue = "Not approved" -%}
        {%- endif -%}
      {%- endfor -%}

    {%- endif -%}
  {%- else -%}
    {#- Unapproved if there is no associated CloudFront distribution -#}
    {%- set policyValue = "Not approved" -%}
  {%- endfor -%}

{%- endif -%}

{{ policyValue }}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To run Turbot Calculated Policies, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)
- Configured credentials to connect to your Turbot workspace

### Configuring Credentials

You must set your `config.tf` or environment variables to connect to your Turbot workspace.
Further information can be found in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider).

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- target_resource
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
