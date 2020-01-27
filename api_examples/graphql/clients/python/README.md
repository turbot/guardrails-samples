# Turbot GraphQL Python example

We recommend the use of virtualenv. To setup and activate do:

```shell
python3 -m venv .venv
source .venv/bin/activate
```

Then install python library dependencies:

```shell
pip install -r requirements.txt
```

Setup environment variables for your Turbot installation:

```shell
export TURBOT_WORKSPACE="https://demo-acme.cloud.turbot.com/"
export TURBOT_ACCESS_KEY_ID=ac61d2e4-730c-4b54-8c3c-6ef180150814
export TURBOT_SECRET_ACCESS_KEY=151b296b-0694-4a28-94c4-4767fa82bb2c
```
or

```shell
export TURBOT_GRAPHQL_ENDPOINT="https://demo-acme.cloud.turbot.com/api/latest/graphql"
export TURBOT_ACCESS_KEY_ID=ac61d2e4-730c-4b54-8c3c-6ef180150814
export TURBOT_SECRET_ACCESS_KEY=151b296b-0694-4a28-94c4-4767fa82bb2c
```
or use a configuration file with creds:

```yaml
default:
    accessKey: dc61d2e4-730c-4b54-8c3c-6ef180150814
    secretKey: 6ef18015-7d0c-2b51-4d2c-dc61d2e63a22
    workspace: 'https://demo-acme.cloud.turbot.com/'
```
This script will automatically search for a `credentials.yml` file in `~/.config/turbot/` or you can save the yaml configuration file anywhere and provide the `--config /path/to/config.yml --profile default` as a command line option.

And run the example:

```shell
python3 run_controls.py --help

python3 run_controls.py --filter "state:error"  

python3 run_controls.py --filter "state:tbd" --execute  
```

When you are done, deactivate the virtualenv:

```shell
deactivate
```
