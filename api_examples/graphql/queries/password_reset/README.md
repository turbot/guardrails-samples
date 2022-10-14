# Run Controls

Find a specific user then set the password

## Prerequisites

To run the scripts, you must have:

- [Turbot CLI](https://turbot.com/v5/docs/7-minute-labs/cli)
- Turbot API Keys for the target environment.

### Turbot configuration

If not done so already, run `turbot configure` to setup proper credentials.

### Setting a password

1. Get the Turbot resource ID of the target user.

```shell script
turbot graphql --profile client-prod --query ./get_users.graphql
```

2. From the user query, find the resource ID of the user.
3. Copy the resource ID into the `user` field in user_password.json
4. Set a good strong password in user_password.json.  You must include symbols and numbers.
5. Run the below query to set the password.

```shell script
turbot graphql --profile client-prod --query ./set_new_password.graphql --variables user_password.json
```
If you get "Internal Error" messages when running the above command, it's likely that your password complexity isn't high enough.

6. Login as that user to verify that the password applied properly.
