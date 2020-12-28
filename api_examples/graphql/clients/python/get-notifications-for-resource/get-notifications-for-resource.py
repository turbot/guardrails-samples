import json
import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint

# -c .config/turbot/credentials.yml --profile env --notification_class resource


@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="[String] Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="[String] Profile to be used from config file.")
@click.option('-l', '--limit', default=1, help="[Int] Set to returns the last n notifications, for more information see https://turbot.com/v5/docs/reference/filter#limiting-results.")
@click.option('-i', '--id', default="tmod:@turbot/turbot#/", help="[String] Find the notification for a resource based on its AKA or ID.")
def run_controls(config_file, profile, limit, id):
    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    # -------------------------------------------------------------------
    # Query 1: Find the resource by id when an AKA is provided
    # -------------------------------------------------------------------
    lookup_query = '''
      query {
        resource(id: "%s") {
          turbot {
            title
            id
          }
        }
      }
    ''' % (id)

    print(f'Looking up resource id for resource: ${id}')

    empty_variables = {}
    lookup_response = endpoint(lookup_query, empty_variables)
    if "errors" in lookup_response:
        return report_graphql_error("aws_mutation", lookup_response["errors"])

    # Look up was successful, set the found item
    found_resource = lookup_response["data"]["resource"]["turbot"]

    print(f'Resource id found: {found_resource["id"]}')

    # -------------------------------------------------------------------------------
    # Query 2: Find the notifications based on the found resource from earlier query.
    # -------------------------------------------------------------------------------
    print(
        f'Querying last {limit} notification(s) for resource {found_resource["title"]}')

    # The query returns unnecessary fields which will be populated depending on the value of the resource type class
    #
    # If the returned notification is a type of the notification class resource, fields returned: [ resource ]
    # If the returned notification is a type of the notification class policyValue, fields returned: [ resource, policyValue ]
    # If the returned notification is a type of the notification class policySetting, fields returned: [ resource, policySetting ]
    # If the returned notification is a type of the notification class control, fields returned: [ resource, control ]
    # If the returned notification is a type of the notification class grant, fields returned: [ resource, grant ]
    # If the returned notification is a type of the notification class activeGrant, fields returned: [ resource ]
    #
    notification_query = '''
      query {
        notifications(filter: "resource:%s limit:%d sort:-timestamp") {
          items
          {
            notificationType

            policyValue {
              default
              value
              state
              reason
              details
              secretValue
              isCalculated
            }

            policyValue {
              default
              value
              state
              reason
              details
              secretValue
              isCalculated
            }
            grant {
              permissionTypeId
              permissionLevelId
              roleName
              validFromTimestamp
              validToTimestamp
            }

            control {
              reason
              details
            }

            resource {
              object
            }
          }
        }
      }
    ''' % (found_resource["id"], limit)

    notification_response = endpoint(notification_query, empty_variables)
    if "errors" in notification_response:
        return report_graphql_error("aws_mutation", notification_response["errors"])

    for item in notification_response["data"]["notifications"]["items"]:
        print(json.dumps(item, indent=1))


def report_graphql_error(section, errors):
    print("Error(s) detected when running mutation: {}".format(section))
    for error in errors:
        print(error["message"])


if __name__ == "__main__":
    run_controls()
