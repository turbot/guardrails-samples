import json
import click
import turbot
from sgqlc.endpoint.http import HTTPEndpoint

# -c .config/turbot/credentials.yml --profile env --notification_type resource
@click.command()
@click.option('-c', '--config-file', type=click.Path(dir_okay=False), help="Pass an optional yaml config file.")
@click.option('-p', '--profile', default="default", help="Profile to be used from config file.")
# In the following line, the code will check for multiple notification types, for a specific type, set the value to that type.
@click.option('-t', '--notification_type', default="resource_created,resource_updated,resource_deleted", help="Set the notification type, for more information see https://turbot.com/v5/docs/concepts/notifications#notification-types")
@click.option('-d', '--datetime_filter', default="<T-10d", help="Configures the date range to filter the result, for more information see https://turbot.com/v5/docs/reference/filter#datetime-filters")
@click.option('-s', '--sort', default="-timestamp", help="The field to use for sorting the results, for more information see https://turbot.com/v5/docs/reference/filter#sorting")
def run_controls(config_file, profile, notification_type, datetime_filter, sort):
    config = turbot.Config(config_file, profile)
    headers = {'Authorization': 'Basic {}'.format(config.auth_token)}
    endpoint = HTTPEndpoint(config.graphql_endpoint, headers)

    # The query returns unnecessary fields which will be populated depending on the value of the notification type class
    #
    # If the type is a member of the notification type resource_*, fields returned: [ resource ]
    # If the type is a member of the notification type policy_value_*, fields returned: [ resource, policyValue ]
    # If the type is a member of the notification type policy_setting_*, fields returned: [ resource, policySetting ]
    # If the type is a member of the notification type control_*, fields returned: [ resource, control ]
    # If the type is a member of the notification type grant-*, fields returned: [ resource, grant ]
    # If the type is a member of the notification type active_grants_*, fields returned: [ resource ]
    #
    query = '''
      query {
        notifications(filter: "notificationType:%s timestamp:%s sort:%s") {
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
    ''' % (notification_type, datetime_filter, sort)

    print(f'Query notifications for type: {notification_type}')
    print(f'Applying timestamp filter: {datetime_filter}')
    print(f'Applying sorting: {sort}')

    empty_variables = {}
    query_response = endpoint(query, empty_variables)
    if "errors" in query_response:
        return report_graphql_error("aws_mutation", query_response["errors"])

    for item in query_response["data"]["notifications"]["items"]:
        print(json.dumps(item, indent=1))


def report_graphql_error(section, errors):
    print("Error(s) detected when running mutation: {}".format(section))
    for error in errors:
        print(error["message"])


if __name__ == "__main__":
    run_controls()
