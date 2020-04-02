import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint

# -c .config/turbot/credentials.yml --profile env --parent 167 --sub 8fd --tenant 7ea --client_id 5b1 --client_key "key"
@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="Profile to be used from config file.")
@click.option('--parent', required=True, help="The resource id for the parent folder of this subscription")
@click.option('--sub', required=True, help="The subscription ID")
@click.option('--tenant', required=True, help="The tenant ID for this subscription")
@click.option('--client_id', required=True, help="The client id for the application used to manage this subscription")
@click.option('--client_key', required=True, help="The client key for the application used to manage this subscription")
def run_controls(config_file, profile, parent, sub, tenant, client_id, client_key):
    """Import an Azure Subscription"""

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    azure_mutation = '''
      mutation CreateAzureSubscription($input: CreateResourceInput!) {
          createResource(input: $input) {
            turbot {
              id
          }
        }
      }
    '''

    credentials_mutation = '''
      mutation SetAzureSubscriptionPolicies($setTenantId: CreatePolicySettingInput!, $setClientId: CreatePolicySettingInput!, $setClientKey: CreatePolicySettingInput!, $setEnvironment: CreatePolicySettingInput!) {
        tenantId: createPolicySetting(input: $setTenantId) {
          turbot {
            id
          }
        }
        clientId: createPolicySetting(input: $setClientId) {
          turbot {
            id
          }
        }
        clientKey: createPolicySetting(input: $setClientKey) {
          turbot {
            id
          }
        }
        environment: createPolicySetting(input: $setEnvironment) {
          turbot {
            id
          }
        }
      }
    '''

    """
    The parent variable holds the resource ID of the folder where this subscription will be imported.
    """
    azure_variables = {
        "input": {
            "parent": parent,
            "type": "tmod:@turbot/azure#/resource/types/subscription",
            "data": {
                "subscriptionId": sub
            },
            "metadata": {
                "azure": {
                    "subscriptionId": sub,
                    "tenantId": tenant
                }
            }
        }
    }

    try:
        print("Importing subscription")
        sub_run = endpoint(azure_mutation, azure_variables)
        sub_rid = sub_run['data']['createResource']['turbot']['id']
        # print("Sub run: {}".format(sub_run))
        print("\tSubscription Resource ID: {}".format(sub_rid))

        credentials_variables = {
            "setTenantId": {
                "type": "tmod:@turbot/azure#/policy/types/tenantId",
                "resource": sub_rid,
                "value": tenant,
                "precedence": "REQUIRED"
            },
            "setClientId": {
                "type": "tmod:@turbot/azure#/policy/types/clientId",
                "resource": sub_rid,
                "value": client_id,
                "precedence": "REQUIRED"
            },
            "setClientKey": {
                "type": "tmod:@turbot/azure#/policy/types/clientKey",
                "resource": sub_rid,
                "value": client_key,
                "precedence": "REQUIRED"
            },
            "setEnvironment": {
                "type": "tmod:@turbot/azure#/policy/types/environment",
                "resource": sub_rid,
                "value": "Global Cloud",
                "precedence": "REQUIRED"
            }
        }

        creds_run = endpoint(credentials_mutation, credentials_variables)
        # print("Creds run: {}".format(creds_run))
        print("Import complete")
    except Exception as e:
        print("Create Sub response: {}".format(sub_run))
        print("Set Creds response: {}".format(creds_run))
        print("Could not set subscription credentials because of error: {}".format(e))


if __name__ == "__main__":
    run_controls()
