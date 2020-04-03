# Run filtered list of controls

The script will get a filtered list of target controls and then try run all filtered controls.
The filter in the example will trigger runs for all Discovery controls in the Turbot environment.

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
node run-controls-for-filter.js
```
