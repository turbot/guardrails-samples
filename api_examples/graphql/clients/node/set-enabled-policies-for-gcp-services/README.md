# Set enable policies for GCP services

The script enables a collection of enabled policies for GCP services.
The configuration of services to enable is defined by a map of services.

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
node set-enabled-policies-for-gcp-services.js
```
