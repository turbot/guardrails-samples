# Turbot Firehose AWS SNS Example

The Firehose AWS SNS mod [@turbot/firehose-aws-sns](https://turbot.com/v5/mods/turbot/firehose-aws-sns) provides capabilities to send notifications to AWS SNS. It is highly recommended to go through the README section of the mod before proceeding further. This setup will create the below listed entities.

  - **AWS SNS Topic**: Notifications are sent to this Topic.
  - **AWS IAM User with inline Policy**: An IAM user with "sns:Publish" permission to the above SNS Topic only.
  - **AWS IAM Access keys**: Access keys for the above IAM User. Turbot uses these access keys in order to access the recipient AWS account.
  - **Turbot Policy Settings**: The IAM access keys and SNS topic details are fed to Turbot via Policy Settings.
  - **Turbot Mutation**: Mutation describes which resources are to be monitored.

## Prerequisites

To run the account import baseline, you must have:

  - [Terraform](https://www.terraform.io) Version 13
  - [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
  -  Terraform [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html)
  - [Credentials](https://turbot.com/v5/docs/reference/cli/installation#setup-your-turbot-credentials) configured to connect to your Turbot workspace


## Running the Example

To run the Firehose AWS SNS example:

  - Go to the Firehose AWS SNS example directory in the repository with `cd firehose-aws-sns-example`
  - Update `variables.tf` with appropriate values
  - Run `terraform init` to initialize the provider plugins
  - Run `terraform plan` and review the plan for Firehose AWS SNS example configuration
  - Run `terraform apply` to build the Firehose AWS SNS example infrastructure

You can refer to [GraphQL in 7 minutes](https://turbot.com/v5/docs/7-minute-labs/graphql) for more details on querying Turbot using Graphql.
Below are a few mutation examples on Firehose AWS SNS mod for quick help.

  ## Example 1
  The below example illustrates the following:
  - Notifies on active grants created at the Turbot level.
  - Usage of resource Aka for creating the watch.
  - Filter is applied at the resource level itself i.e., only the grants at Turbot level are notified.

  *NOTE*: When a new grant is created, `grant_created` notification type is emitted, when a grant is activated `active_grants_created` is emitted. By default, all the new grants on UI are made active, unless the `Activate for immediate use` is unchecked, under the **Advanced** section of the `Grant Permission` page.

```graphql
mutation CreateWatch($input: CreateWatchInput!) {
  createWatch(input: $input) {
    filters
    handler
    turbot {
      id
      resourceId
    }
  }
}
```
```json
{
  "input": {
    "resource": "tmod:@turbot/turbot#/",
    "action": "tmod:@turbot/firehose-aws-sns#/action/types/router",
    "filters": [
      "level:self notificationType:active_grants_created"
    ]
  }
}
```

  ## Example 2
  The below example illustrates the following:
  - Notifies on active grants deleted at the Turbot level.
  - Usage of resource Id for creating the watch.
  - Filter is applied at the resource level and its descendant i.e., the grants deleted at Turbot level and below in the hierarchy are notified.

  *NOTE*: You can use multiple notification types in a single filter. In order to get notifications for active grants created and deleted, you can use the filter. `"filters": ["level:self,descendant notificationType:active_grants_created,active_grants_deleted"]`

```graphql
mutation CreateWatch($input: CreateWatchInput!) {
  createWatch(input: $input) {
    filters
    handler
    turbot {
      id
      resourceId
    }
  }
}
```
```json
{
  "input": {
    "resource": "173249879813121",
    "action": "tmod:@turbot/firehose-aws-sns#/action/types/router",
    "filters": [
      "level:self,descendant notificationType:active_grants_deleted"
    ]
  }
}
```

  ## Example 3
  The below example illustrates the following:
  - Notifies on resource updates to `AWS > S3 > Bucket` resource type at the resource 173249879813121 and its descendants.
  - Usage of ResourceType Id for creating the filter.

```graphql
mutation CreateWatch($input: CreateWatchInput!) {
  createWatch(input: $input) {
    filters
    handler
    turbot {
      id
      resourceId
    }
  }
}
```
```json
{
  "input": {
    "resource": "173249879813121",
    "action": "tmod:@turbot/firehose-aws-sns#/action/types/router",
    "filters": [
      "level:self,descendant notificationType:resource_updated resourceTypeId:tmod:@turbot/aws-s3#/resource/types/bucket"
    ]
  }
}
```

  ## Example 4
  The below example illustrates the following:
  - Notifies on control updates for `AWS > S3 > Bucket > Public Access Block` control type at the resource 173249879813121 and its descendants.
  - Usage of ControlTypeType Id for creating the filter.

```graphql
mutation CreateWatch($input: CreateWatchInput!) {
  createWatch(input: $input) {
    filters
    handler
    turbot {
      id
      resourceId
    }
  }
}
```
```json
{
  "input": {
    "resource": "173249879813121",
    "action": "tmod:@turbot/firehose-aws-sns#/action/types/router",
    "filters": [
      "level:self,descendant notificationType:control_updated controlTypeId:tmod:@turbot/aws-s3#/control/types/bucketLevelPublicAccessBlock"
    ]
  }
}
```

  ## Example 5
  The below example illustrates the following:
  - Notifies on action updates for all resource types that have a tag `Environment:Development` at the resource 173249879813121 and its descendants.
  - Usage of $. search in filters.

```graphql
mutation CreateWatch($input: CreateWatchInput!) {
  createWatch(input: $input) {
    filters
    handler
    turbot {
      id
      resourceId
    }
  }
}
```
```json
{
  "input": {
    "resource": "173249879813121",
    "action": "tmod:@turbot/firehose-aws-sns#/action/types/router",
    "filters": [
      "level:self,descendant notificationType:action_notify $.turbot.tags:Environment=Development"
    ]
  }
}
```

  ## Additional Queries
  - List the watches in the Turbot workspace.

```graphql
query MyWatches {
  watches(filter: "") {
    items {
      handler
      filters
      watchRules {
        metadata {
          filters
        }
      }
    }
  }
}
```

- Describe a watch (with Turbot ID as `202914621443109`)

```graphql
query Watch {
  watch(id: "202914621443109") {
    filters
    handler
    description
    resource {
      title
    }
  }
}
```
- Delete a watch (with Turbot ID as `202897474228567`)
```graphql
mutation DeleteMyWatch {
  deleteWatch(input: {id: "202897474228567"}) {
    handler
    filters
  }
}
```