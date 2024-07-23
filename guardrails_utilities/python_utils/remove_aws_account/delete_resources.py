import turbot
import click
import requests
import sys


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-a', '--account-aka', default="state:tbd", help='[String] AKA for account to delete e.g. "arn:aws:::337619943512"')
@click.option('--disable', is_flag=True, help="If set will disable all cmdb policies for the aws account.")
@click.option('--delete', is_flag=True, help="If set will delete resources from Turbot workspace.")
@click.option('--delete-acct', is_flag=True, help="If set will delete the account from the Turbot workspace.")

def delete_resources(config_file, profile, account_aka, disable, delete, delete_acct):
    """ Finds all resources matching the provided account-aka, then deletes them if --execute is set."""
    """
        Example
        ---------------
        Check Mode: 
        $ python3 delete_resources.py -p demo -a "arn:aws:::111222333444" 

        Disable CMDB, but don't delete
        $ python3 delete_resources.py -p demo -a "arn:aws:::111222333444" --disable
        
        Delete Resources from the account: 
        $ python3 delete_resources.py -p demo -a "arn:aws:::111222333444" --delete
    """

    requests.packages.urllib3.disable_warnings()
    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint

    cmdb_policy_query = '''
        query Policies($filter: [String!]!, $paging: String) {
            policies: policyTypes(filter: $filter, paging: $paging) {
                items {
                    uri
                }
                metadata {
                    stats {
                        total
                    }
                }
                paging {
                    next
                }
            }
        }
    '''

    print("Collecting CMDB Policy Types...")
    paging = None
    cmdb_policy_filter = "aws Cmdb -CmdbAttributes"
    policies = []

    while True:
        variables = {'filter': cmdb_policy_filter, 'paging': paging}
        result = run_query(endpoint, headers, cmdb_policy_query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        for item in result['data']['policies']['items']:
            policies.append(item)
        if not result['data']['policies']['paging']['next']:
            break
        else:
            print("found {} ...".format(len(policies)))
            paging = result['data']['policies']['paging']['next']

    print("\nFound {} Total Policies".format(len(policies)))

    if not disable:
        print("\n --disable flag not set... CMDB policies not changed")
    else:

        # Query to get the Turbot ID of Account 
        account_query = '''
            query MyQuery {{
                resource(id: "{aka}") {{
                    turbot {{
                        id
                    }}
                }}
            }}
        '''
  
        data = run_query(endpoint, headers, account_query.format(aka = account_aka), None)

        # Turbot resource Id of the account resource at which the policy should be set.
        # Can also set it explicitly e.g. acctResourceId = "176097085664257";
        acctResourceId = data['data']['resource']['turbot']['id']
        
        create_mutation = '''
            mutation CreatePolicySetting($input: CreatePolicySettingInput!) {
                createPolicySetting(input: $input) {
                    turbot {
                        id
                    }
                }
            }
        '''

        update_mutation = '''
            mutation UpdatePolicySetting($input: UpdatePolicySettingInput!) {
                updatePolicySetting(input: $input) {
                    turbot {
                        id
                    }
                }
            }
        '''

        find_setting_query = '''
            query findSetting {{
                policySettings(filter: "resourceId:'{}' policyTypeId:'{}'") {{
                    metadata {{
                        stats {{
                            total
                        }}
                    }}
                    items {{
                        turbot {{
                            id
                        }}
                    }}
                }}
            }}
        '''

        for policy in policies:
            data = run_query(endpoint, headers, find_setting_query.format(acctResourceId, policy['uri']), None)
            if data['data']['policySettings']['metadata']['stats']['total'] > 0:
                ## Existing policy setting found, update it
                policySettingResourceId = data['data']['policySettings']['items'][0]['turbot']['id']

                update_vars = {
                    "input": {
                        "id": policySettingResourceId,
                        "precedence": "REQUIRED",
                        "value": "Enforce: Disabled",
                        "note": "Set via account delete script"
                    }
                }

                print("Updating existing CMDB policy to 'Enforce: Disabled' for {}".format(policy['uri']))
                try:
                    run = run_query(endpoint, headers, update_mutation, update_vars)
                    print(run)
                except Exception as e:
                    print(e)

            else:
                ## No existing policy setting found, create it
                create_vars = {
                    'input': {
                        'type': policy['uri'],
                        'resource': acctResourceId,
                        'precedence': "REQUIRED",
                        'value': "Enforce: Disabled",
                        'note': "Set via account delete script"
                    }
                }
                print("Setting CMDB policy to 'Enforce: Disabled' for {}".format(policy['uri']))
                try:
                    run = run_query(endpoint, headers, create_mutation, create_vars)
                    print(run)
                except Exception as e:
                    print(e)

    query = '''
        query Targets($filter: [String!]!, $paging: String) {
            targets: resources(filter: $filter, paging: $paging) {
                metadata {
                    stats {
                        total
                    }
                }
                items {
                    turbot {
                        id
                    }
                    akas
                }
                paging {
                    next
                }
            }
        }
    '''
    target_count = '''
        query Targets($filter: [String!]!) {
            targets: resources(filter: $filter) {
                metadata {
                    stats {
                        total
                    }
                }
            }
        }
    '''

    if delete_acct:
        delete = True
        level = "self"
    else:
        level = "descendant"
    
    filter = 'resourceId:"{}" level:{}'.format(account_aka, level)
    preflight_variables = {'filter': filter}
    preflight = run_query(endpoint, headers, target_count, preflight_variables)
    print("Target count: {}".format(preflight['data']['targets']['metadata']['stats']['total']))

    
    targets = []
    paging = None

    print("Looking for resources in account {} ...".format(account_aka))
    
    while True:
        variables = {'filter': filter, 'paging': paging}
        result = run_query(endpoint, headers, query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        for item in result['data']['targets']['items']:
            targets.append(item)
        if not result['data']['targets']['paging']['next']:
            break
        else:
            print("found {} ...".format(len(targets)))
            paging = result['data']['targets']['paging']['next']

    print("\nFound {} Total Targets".format(len(targets)))

    #if not execute:
    if not delete:
        print("\n --delete flag not set... no resource deletion has occured.")
        print("")
    else:
        mutation = '''
          mutation DeleteResource($input: DeleteResourceInput!) {
            deleteResource(input: $input) {
              turbot{
                id
              }
            }
          }
        '''

        for resource in targets:
            vars = {'input': {'id': resource['turbot']['id']}}
            print(vars)
            try:
                run = run_query(endpoint, headers, mutation, vars)
                print(run)
            except Exception as e:
                print(e)


def run_query(endpoint, headers, query, variables):
    request = requests.post(
        endpoint,
        headers=headers,
        json={'query': query, 'variables': variables},
        verify=False
    )
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception("Query failed to run by returning code of {}. {}".format(request.status_code, query))


if __name__ == "__main__":
    if (sys.version_info > (3, 4)):
        try:
            delete_resources()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.5+")
        print("Your Python version is: {}.{}.{}".format(
            sys.version_info.major, sys.version_info.minor, sys.version_info.micro))
        if (sys.version_info < (3, 0)):
            hint = ["Maybe try: `python3"] + sys.argv
            hint[len(sys.argv)] = hint[len(sys.argv)] + "`"
            print(*hint)
