# Turbot GraphQL Shell / curl example

Setup environment variables for your Turbot installation:

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=12345678-abcd-5678-1a2b-111222333444
export TURBOT_SECRET_ACCESS_KEY=12345678-abcd-5678-1a2b-111222333444
```

And run the example:

```shell
./index.sh
```

### Available scripts

| Title                                          | Description                                         |
| ---------------------------------------------- | --------------------------------------------------- |
| [AWS Account Import](./run-controls/README.md) | Run controls based on some filter using BASH shell. |
