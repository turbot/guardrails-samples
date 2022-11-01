import turbot
import click
import requests
import sys


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False),
              help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-e', '--execute', is_flag=True, help="Will destroy malformed AKAs if set")
def clean_bad_aka(config_file, profile, execute):
    """Finds all malformed AKAs.  Resources deleted out of Turbot if --execute is set."""

    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = config.graphql_endpoint
    session = requests.Session()
    session.headers.update(headers)

    # Set up the connection for all later calls.
    session.get(config.graphql_endpoint)

    aka_filter = "$.turbot.akas.*:/^arn::/ limit:500"
    query: str = '''
     query Targets($filter: [String!]!, $paging: String) {
        targets: resources(filter: $filter, paging: $paging) {
        items {
          aka: get(path: "turbot.akas")
          turbot {  id  }
          type {
            uri
          }
          parent {
            turbot {
                id
            }
          }
        }
        paging {
            next
        }
      }
    }
        '''

    targets = []
    paging = None
    print("Looking for targets...")
    print("action\t[akas]\tresource_id\tresource_type\tparent_id")

    # structure
    # discovery_pairs = { 'parent_id': {resourceType, resourceType, ...},
    #                     'parent_id': {resourceType, resourceType, ...}}
    # We never need duplicate values so build as dict{set{}}
    discovery_pairs = {}

    while True:
        variables = {'filter': aka_filter, 'paging': paging}
        result = run_query(session=session, endpoint=endpoint, query=query, variables=variables)
        # result = run_query(endpoint, headers, query, variables)

        if "errors" in result:
            for error in result['errors']:
                print(error)
            break

        for item in result['data']['targets']['items']:
            parent_id = item['parent']['turbot']['id']
            resource_type_id = item['type']['uri']
            if item['type']['uri'] not in ["tmod:@turbot/aws#/resource/types/account",
                                           "tmod:@turbot/aws#/resource/types/region"]:
                # targets.append(item)
                print("remove\t{}\t{}\t{}\t{}".format(item['aka'],
                                                      item['turbot']['id'],
                                                      resource_type_id,
                                                      parent_id))
            else:
                print("skip\t{}\t{}\t{}\t{}".format(item['aka'],
                                                    item['turbot']['id'],
                                                    resource_type_id,
                                                    parent_id))
            if parent_id in discovery_pairs.keys():
                discovery_pairs[parent_id].add(resource_type_id)
            else:
                discovery_pairs[parent_id] = set()
                discovery_pairs[parent_id].add(resource_type_id)

        if not result['data']['targets']['paging']['next']:
            break
        else:
            print("Targets discovery complete.")
            paging = result['data']['targets']['paging']['next']

    # print(discovery_pairs)

    if not execute:
        print("\n --execute flag not set... exiting.")
    else:
        mutation = '''
mutation DeleteResource($input: DeleteResourceInput!) {
  deleteResource(input: $input){
    akas
  }
}
        '''

        for resource in targets:
            target_vars = {'input': {'id': resource['turbot']['id']}}
            # print(vars)
            try:
                run = run_query(session=session, endpoint=endpoint, query=mutation, variables=target_vars)
                print("Deleted: {}".format(run['data']['deleteResource']['akas']))
                pass
            except Exception as err:
                print(err)
        run_discovery(session=session, endpoint=endpoint, duplicates=discovery_pairs)


def run_discovery(session, endpoint, duplicates):
    """
    After the malformed resources have been removed, they need to be rediscovered.  This filter string will return
    the discovery control for the resource type just destroyed.
    Essential elements:
    "Discovery resourceId:123123123123 controlCategoryId:'tmod:@turbot/turbot#/control/categories/cmdb'" \
    "controlTypeId:'tmod:@turbot/aws-ec2#/resource/types/instance'"
    - "Discovery": Excludes CMDB controls.  We don't need to rerun those.
    - resourceId: Limit the scope to the account or region that owns the discovery control.
    - controlCategoryId:  Make sure we only get Discovery or CMDB controls.
    - controlTypeId: limit results to only the specific resource type we care about.
    """
    paging = None
    query = '''
      query Targets($filter: [String!]!, $paging: String) {
        targets: controls(filter: $filter, paging: $paging) {
          items {
            turbot { id }
            state
            type { uri }
          }
          paging {
            next
          }
        }
      }
    '''
    mutation = '''
      mutation RunControl($input: RunControlInput!) {
        runControl(input: $input) {
          turbot {
            id
          }
        }
      }
    '''
    for resource in duplicates.keys():
        for resource_type in duplicates[resource]:
            control_filter = "Discovery controlCategoryId:'tmod:@turbot/turbot#/control/categories/cmdb'" \
                             "resourceId:{}  controlTypeId:'{}'".format(resource, resource_type)
            variables = {'filter': control_filter, 'paging': paging}
            print("Looking for control for resource:{}, resource_type:{}".format(resource, resource_type))

            find_control_id = run_query(session=session, endpoint=endpoint, query=query, variables=variables)
            control_id = find_control_id['data']['targets']['items'][0]['turbot']['id']
            control_type = find_control_id['data']['targets']['items'][0]['type']['uri']
            print("Found control_id: {} of type '{}'.  Running...".format(control_id, control_type))

            control_vars = {'input': {'id': control_id}}
            try:
                run_query(session=session, endpoint=endpoint, query=mutation, variables=control_vars)
            except Exception as err:
                print(err)
    if len(duplicates.keys()) > 0:
        print("All discovery controls have been rerun.  Exiting.")
    else:
        print("Didn't find any discovery controls to run. Exiting.")


def run_query(session, endpoint, query, variables):
    request = session.post(endpoint, json={'query': query, 'variables': variables})
    if request.status_code == 200:
        return request.json()
    else:
        raise Exception("Query failed to run by returning code of {}. {}".format(
            request.status_code, query))


if __name__ == "__main__":
    if sys.version_info > (3, 4):
        try:
            clean_bad_aka()
        except Exception as e:
            print(e)
    else:
        print("This script requires Python v3.5+")
        print("Your Python version is: {}.{}.{}".format(
            sys.version_info.major, sys.version_info.minor, sys.version_info.micro))
        if sys.version_info < (3, 0):
            hint = ["Maybe try: `python3"] + sys.argv
            hint[len(sys.argv)] = hint[len(sys.argv)] + "`"
            print(*hint)
