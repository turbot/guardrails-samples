# Get notifications for a specific resource

This script provides an example of how to look up a resource id using a Turbot aka.
From there the script will return the last notification for the found resource if it exists.

In this example, the script is configured to return the last notification only.
For more information on how to (limit results)[https://turbot.com/v5/docs/reference/filter#limiting-results].

In this example, the script will sort the notifications displaying most recent first.
For more information on how to use (sorting)[https://turbot.com/v5/docs/reference/filter#sorting].

## Example

### Dependencies

Install the dependencies:

```shell
npm install
```

### Turbot configuration

Setup environment variables for your Turbot installation:

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=ac61d2e4-730c-4b54-8c3c-6ef180150814
export TURBOT_SECRET_ACCESS_KEY=151b296b-0694-4a28-94c4-4767fa82bb2c
```

### Running the example

And run the example:

```shell
node get-specific-resource-last-notification.js
```
