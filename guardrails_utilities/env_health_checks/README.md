# Environment Health Checks
In addition to the CloudWatch dashboards, there a few GraphQL and CloudWatch insights queries to run against a workspace to assess its health.  These queries can be run from the Developer console in the Turbot console.

## How to run?
For the GraphQL queries, the easiest way to run these queries is to log into the Turbot console, then click the Developer console in the upper right corner.  Copy and paste the query into the Developer console then click run.  Results show up in the right panel.  For more info, refer to the [GraphQL 7-Minute Lab](https://turbot.com/v5/docs/7-minute-labs/graphql)

For the CloudWatch Insights queries, these will need to be run in the AWS console of the Turbot Master account.  CloudWatch Insights requires you to choose a log group.  Choose `/aws/lambda/turbot_X_Y_Z_worker`.
## When to run?
In periods of low change, once a week is probably enough.  In periods of high churn such as new policy rollout or account imports, running these queries daily makes sense.

Turbot customer success teams may ask for the results of these queries when a ticket is opened.  Unhealthy environments complicate troubleshooting.

## Controls Query
- Run the `graphql/list_controls_summary_by_state.graphql` to  get an summary of how many controls are in `ok`, `error`, `tbd`, etc.  Sudden spikes in `tbd`, `error` or `invalid` is cause for detailed investigation.

## Resource Types Query
- Run the `graphql/list_{provider}_resourcetype_summaries.graphql` query appropriate to your environment.

## Events Queries
- In `cloudwatch_insights/view*.query` are a number of queries to be used in CloudWatch insights to see what Turbot is working on as well as incoming events from the environment.