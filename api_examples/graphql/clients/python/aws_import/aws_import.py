import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="Profile to be used from config file.")
@click.option('--parent', required=True, help="The resource id for the parent folder of this subscription.")
@click.option('--account', required=True, help="The AWS account ID.")
@click.option('--role_arn', required=True, help="IAM Role used by Turbot for access to the AWS account.")
@click.option('--external_id', required=True, help="External ID for secure access to the Turbot IAM Role.")
def run_controls(config_file, profile, parent, account, role_arn, external_id):
    """Import an AWS Account"""

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    aws_mutation = '''
      mutation CreateAwsAccount($input: CreateResourceInput!) {
          createResource(input: $input) {
            turbot {
              id
          }
        }
      }
    '''

    credentials_mutation = '''
      mutation SetAwsAccountPolicies($setRoleArn: CreatePolicySettingInput!, $setExternalId: CreatePolicySettingInput!) {
        roleArn: createPolicySetting(input: $setRoleArn) {
          turbot {
            id
          }
        }
        externalId: createPolicySetting(input: $setExternalId) {
          turbot {
            id
          }
        }
      }
    '''

    #
    # The parent variable holds the resource ID of the folder where this account will be imported.
    #
    aws_variables = {
        "input": {
            "parent": parent,
            "type": "tmod:@turbot/aws#/resource/types/account",
            "data": {
                "Id": account
            },
            "metadata": {
                "aws": {
                    "accountId": account,
                    # NOTE: gov-cloud not yet supported #
                    "partition": "aws"
                }
            }
        }
    }

    print("Importing account: {}".format(account))
    account_response = endpoint(aws_mutation, aws_variables)
    if "errors" in account_response:
        return report_graphql_error("aws_mutation", account_response["errors"])

    account_rid = account_response['data']['createResource']['turbot']['id']
    print("Created Account Resource ID: {}".format(account_rid))

    credentials_variables = {
        "setRoleArn": {
            "type": "tmod:@turbot/aws#/policy/types/turbotIamRole",
            "resource": account_rid,
            "value": role_arn,
            "precedence": "REQUIRED"
        },
        "setExternalId": {
            "type": "tmod:@turbot/aws#/policy/types/turbotIamRoleExternalId",
            "resource": account_rid,
            "value": external_id,
            "precedence": "REQUIRED"
        }
    }

    creds_response = endpoint(credentials_mutation, credentials_variables)
    if "errors" in creds_response:
        return report_graphql_error("credentials_mutation", creds_response["errors"])

    print("Import complete")


def report_graphql_error(section, errors):
    print("Error(s) detected when running mutation: {}".format(section))
    for error in errors:
        print(error["message"])


if __name__ == "__main__":
    run_controls()
