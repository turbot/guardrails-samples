from .resource_service import ResourceService
from .resource import Resource
import logging


class CloudwatchLogGroup(Resource):
    def __init__(self, session, region, logs) -> None:
        self.logs = logs
        self.region = region

        super().__init__(session)
# what does this do?
    def details(self):
        return f'cloudwatch/log {self.logs["Name"]}'

    def delete(self, dry_run):
        logger = logging.getLogger(__name__)
        log_client = self.session.create_client('logs', self.region)

        response = log_client.describe_log_groups()

# adds list of groups from response to array and deletes/prints log groups to window
        groups = []
        for group in response['logGroups']:
            if not dry_run:
                groups.append(group['logGroupName'])
            else:
                logger.info(f"Would remove log group {group['logGroupName']})

        if not dry_run:
            log_client.delete_log_group(logGroupName=self.logs["Name"])
            logger.info(f"Deleted log group {self.logs['Name']}")
        else:
            logger.info(f"Would delete log group {self.logs['Name']}")


class CloudWatchLogsResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "event", "rule")

    def get_all(self, region):
        name_prefix = []
        for filter in self.recipe["filters"]:
            if filter["type"] == "startswith":
                name_prefix = filter["value"]

        log_client = self.session.create_client('logs', region)

        response = log_client.list_rules(NamePrefix=name_prefix)

        return [CloudwatchLogGroup(self.session, region, rule) for rule in response["Rules"]]


#    - name: "Cloudwatch Log Groups - Delete"
#       service: cloudwatch
#       resource: LogGroups
#       filters:
#         - type: startswith
#           value: 
#             - /aws/lambda/turbot_ban
#             - /turbot/ban
#       actions:
#         - delete