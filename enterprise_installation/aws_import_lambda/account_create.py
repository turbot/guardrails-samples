import logging
import requests
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)

class GraphQlException(Exception):
    def __init__(self, *args: object) -> None:
        super().__init__(*args)


class GraphQl:
    def __init__(self, endpoint: str, access_key: str, secret_access_key: str) -> None:
        if not endpoint or type(endpoint) is not str:
            raise ValueError("endpoint is missing or not string type")

        if not access_key or type(access_key) is not str:
            raise ValueError("access_key is missing or not string type")

        if not secret_access_key or type(secret_access_key) is not str:
            raise ValueError("secret_access_key is missing or not string type")

        self.__endpoint = endpoint
        self.__access_key = access_key
        self.__secret_access_key = secret_access_key

    def get_endpoint(self) -> str:
        return self.__endpoint

    def get_access_key(self) -> str:
        return self.__access_key

    def get_secret_access_key(self) -> str:
        return self.__secret_access_key

    def run_query(self, query: str, variables: dict) -> dict:
        if not query or type(query) is not str:
            raise ValueError("query is missing or not string type")

        if not variables or type(variables) is not dict:
            raise ValueError("variables is missing or not dict type")

        logger.info(f"Query: {query}")
        logger.info(f"Variables: {variables}")

        response = requests.post(
            self.get_endpoint(),
            auth=(self.get_access_key(), self.get_secret_access_key()),
            json={'query': query, 'variables': variables}
        )

        if response.status_code != 200 or response.json().get("errors"):
            logger.info("GraphQL query failed, throwing exception")
            raise GraphQlException(f"Query failed: {response.text}")

        response = response.json()
        logger.info(f"Query result: {response}")

        return response


def get_create_account_mutation():
    return '''
        mutation CreateAWSAccount($input: CreateResourceInput!) {
            createResource(input: $input) {
                turbot {
                    id
                }
            }
        }
    '''

def get_create_account_variables(parent_folder_id, aws_account_id, aws_partition):
    if not parent_folder_id or type(parent_folder_id) is not str:
        raise ValueError("parent_folder_id is missing or not string type")

    if not aws_account_id or type(aws_account_id) is not str:
        raise ValueError("aws_account_id is missing or not string type")
    
    if not aws_partition or type(aws_partition) is not str:
        raise ValueError("aws_partition is missing or not string type")

    return {
        "input": {
            "parent": parent_folder_id,
            "type": "tmod:@turbot/aws#/resource/types/account",
            "data": {
                "Id": aws_account_id
            },
            "metadata": {
                "aws": {
                    "accountId": aws_account_id,
                    "partition": aws_partition
                }
            }
        }
    }


def get_account_configuration_mutation():
    return '''
        mutation SetIamRoleArnPolicy($setIamRoleArnPolicy: CreatePolicySettingInput!, $setIamRoleExternalIdPolicy: CreatePolicySettingInput!) {
            IamRoleArnPolicy: createPolicySetting(input: $setIamRoleArnPolicy) {
                turbot {
                    id
                }
            }   
            IamRoleExternalIdPolicy: createPolicySetting(input: $setIamRoleExternalIdPolicy) {
                turbot {
                    id
                }
            }
        }
    '''

def get_account_configuration_variables(aws_resource_id, role_arn, external_id):
    if not aws_resource_id or type(aws_resource_id) is not str:
        raise ValueError("aws_resource_id is missing or not string type")

    if not role_arn or type(role_arn) is not str:
        raise ValueError("role_arn is missing or not string type")

    if not external_id or type(external_id) is not str:
        raise ValueError("role_arn is missing or not string type")

    return {
        "setIamRoleArnPolicy": {
            "type": "tmod:@turbot/aws#/policy/types/turbotIamRole",
            # the Turbot resource ID returned from STEP 1.
            "resource": aws_resource_id,
            # role policy aka, can be retrieved from the AWS console.
            "value": role_arn,
            "precedence": "REQUIRED"
        },
        "setIamRoleExternalIdPolicy": {
            "type": "tmod:@turbot/aws#/policy/types/turbotIamRoleExternalId",
            "resource": aws_resource_id,  # the Turbot resource ID returned from STEP 1.
            # the External ID from the role using AWS console. It can be found next to trust relationship.
            "value": external_id,
            "precedence": "REQUIRED"
        }
    }

def import_account(aws_account_id, role_arn, external_id, parentFolder, endpoint, turbotAccessKey, turbotSecretKey):
    
    graph_ql = GraphQl(endpoint, turbotAccessKey, turbotSecretKey)
    
    create_account_mutation = get_create_account_mutation()
    create_account_variables = get_create_account_variables(parentFolder, aws_account_id)

    response = graph_ql.run_query(create_account_mutation, create_account_variables)

    aws_resource_id = response["data"]["createResource"]["turbot"]["id"]
    account_configuration_mutation = get_account_configuration_mutation()
    account_configuration_variables = get_account_configuration_variables(aws_resource_id, role_arn, external_id)

    graph_ql.run_query(account_configuration_mutation, account_configuration_variables)
    logger.info("Example complete")


def lambda_handler(event,context):
    logger.info("Starting Handler")
    logger.info(event)

    ssmClient = boto3.client('ssm')

    try:
        logger.info("Parse Lambda Params")
        awsAccountId = os.environ['AWS_ACCOUNT_ID']
        awsPartition = os.environ['AWS_PARTITION']
        turbotParentId = os.environ['TURBOT_PARENT_ID']
        turbotRoleArn = os.environ['TURBOT_ROLE_ARN']
        turbotRoleExtId = os.environ['TURBOT_ROLE_EXT_ID']

        logger.info("Parse SSM Params")
        response = ssmClient.get_parameter(
            Name='/turbot/aws-import/turbot/accessKey',
            WithDecryption=True
        )
        turbotAccessKey = response['Parameter']['Value']

        response = ssmClient.get_parameter(
            Name='/turbot/aws-import/turbot/secretKey',
            WithDecryption=True
        )
        turbotSecretKey = response['Parameter']['Value']

        response = ssmClient.get_parameter(
            Name='/turbot/aws-import/turbot/url',
            WithDecryption=False
        )
        turbotUrl = response['Parameter']['Value']
        if turbotUrl[-1] == '/':
            endpoint = "{}api/v5/graphql".format(turbotUrl)
        else:
            endpoint = "{}/api/v5/graphql".format(turbotUrl)

    except Exception as e:
        logger.info("ERROR: {}".format(e))

    logger.info("params parsing finished.")

    logger.info("Attempting import")

    import_account(awsAccountId, turbotRoleArn, turbotRoleExtId, turbotParentId, endpoint, turbotAccessKey, turbotSecretKey)
    
    logger.info("Import Complete")