# Simple query

A example of a basic GraphQL query to a Turbot environment

## Example

### Dependencies

Install the dependencies:

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### Turbot configuration

Setup environment variables for your Turbot installation:

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=12345678-1a2b-3c4b-5e6f-111222333444
export TURBOT_SECRET_ACCESS_KEY=12345678-1a2b-3c4b-5e6f-111222333444
```

### Running the example

And run the example:

```shell
python simple-simple_query.py
```
