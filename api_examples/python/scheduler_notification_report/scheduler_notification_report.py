import requests
import yaml
import json
from base64 import b64encode
import csv

# Load configuration from config.yaml
with open('config.yaml', 'r') as config_file:
  config = yaml.safe_load(config_file)

access_key = config['api-access-key']
secret_key = config['api-secret-key']

auth_bytes = f"{access_key}:{secret_key}".encode("utf-8")
auth_token = b64encode(auth_bytes).decode()

workspace_url = config['workspace-url']
if workspace_url[-1] == "/": 
  endpoint = f"{workspace_url}api/v5/graphql"
else: 
  endpoint = f"{workspace_url}/api/v5/graphql"

before_date = config['before-date']
after_date = config['after-date']
turbot_id = config['turbot-id']
resource_type_filter = config['resource-type-filter']
poller_rate = config['poller-rate']

headers = {
  "Authorization": f"Basic {auth_token}",
  "Content-Type": "application/json"
}

def fetch_notifications(variables):
  notification_query = """
    query TurbotResourceNotifications($filter: [String!], $paging: String) {
      notifications(filter: $filter, paging: $paging, dataSource: DB) {
        items {
          resource {
            akas
          }
          turbot {
            id
            processId
            createTimestamp
          }
          message
        }
        paging {
          next
        }
      }
    }
  """
  response = requests.post(endpoint, json={'query': notification_query, 'variables': variables}, headers=headers)
  response.raise_for_status()
  return response.json()

schedule_actions = []
next_page = None
total = 0

print("Starting...")
while True:
  variables = {
    "filter": [
      "notificationType:action_notify",
      "resourceTypeLevel:self",
      f"resourceTypeId:{resource_type_filter}",
      f"actorIdentityId:{turbot_id}",
      f"timestamp:>{before_date} timestamp:<{after_date}",
      f"limit:{poller_rate}"
    ],
    "paging": next_page
  }
  result = fetch_notifications(variables)
  items = result['data']['notifications']['items']
  for item in items:
    if "stop" in item['message'].lower() or "start" in item['message'].lower():
      schedule_actions.append(item)
  total = total + poller_rate
  print(f"found {len(schedule_actions)} scheduler actions across {total} notifications")
  paging = result['data']['notifications']['paging']
  if paging and paging['next']:
    next_page = paging['next'] 
  else:
    break

print(f"Total scheduler notifications: {len(schedule_actions)}")

with open('scheduler_actions.json', 'w') as json_file:
  json.dump(schedule_actions, json_file, indent=2)

csv_columns = ['timestamp', 'instance_arn', 'message', 'details']
csv_file = "scheduler_actions.csv"

with open(csv_file, 'w') as csvfile:
  writer = csv.DictWriter(csvfile, fieldnames=csv_columns)
  writer.writeheader()
  for action in schedule_actions:
    timestamp = action['turbot']['createTimestamp']
    instance_arn = action['resource']['akas'][0] if action['resource']['akas'] else ''
    message = action['message']
    link = f"{workspace_url}/apollo/processes/{action['turbot']['processId']}/notifications/{action['turbot']['id']}"
    writer.writerow({
      'timestamp': timestamp,
      'instance_arn': instance_arn,
      'message': message,
      'details': link
    })