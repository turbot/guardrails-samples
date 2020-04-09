# Get notifications by notification class

This script will return a filtered collection of notifications the notification class to filter results.
For more information on (filtering notifications)[https://turbot.com/v5/docs/reference/filter/notifications#filtering-notifications].

In this example, the script will return all notifications that were returned over the last 10 days.
For more information on how to use (datetime filters)[https://turbot.com/v5/docs/reference/filter#datetime-filters].

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
node get-notifications-by-class.js
```
