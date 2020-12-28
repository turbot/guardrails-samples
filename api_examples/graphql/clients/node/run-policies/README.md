# Run Policies

Run this script to run all policies using the states of the policy as a filter to select the policies to run.

The variable `filter` is used by the script to configure the policies to run that match the specified policy state(s).

The default state for the variable `filter` is `state:tbd`.

States for policies in Turbot can be:

- ok
- tbd
- error
- invalid

For further reference see [filtering policy values](https://turbot.com/v5/docs/reference/filter/policies#filtering-policy-values)

Multiple states can be added by separating each state using a comma.
For example when the variable `filter` is set to `state:tbd,error` the script will run all policies that are
in either the state of `tdb` or `error`.

## Running Script

### Dependencies

Install the dependencies at in the script folder by running the command:

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
node run-policies.js
```
