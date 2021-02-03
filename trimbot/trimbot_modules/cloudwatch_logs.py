from .resource_service import ResourceService
from .resource import Resource
import logging


class CloudWatchLogGroup(Resource):
    def __init__(self, session, region, log_groups) -> None:
        self.log_groups = log_groups
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.log_client = session.create_client('logs', self.region)

        super().__init__(session)
# what does this do?

    def details(self):
        return f'cloudwatch/log {self.log_groups["logGroupName"]}'

    def delete(self, dry_run):
        if not dry_run:
            self.log_client.delete_log_group(logGroupName=self.log_groups["logGroupName"])
            self.logger.info(f"Deleted log group {self.log_groups['logGroupName']}")
        else:
            self.logger.info(f"Would delete log group {self.log_groups['logGroupName']}")


class CloudWatchLogsResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "event", "rule")

    def get_all(self, region):
        log_client = self.session.create_client('logs', region)

        resources = []

        if not self.recipe["filters"]:
            for filter in self.recipe["filters"]:
                if filter["type"] == "startswith":
                    for name_prefix in filter["value"]:
                        response = log_client.describe_log_groups(logGroupNamePrefix=name_prefix)
                        for log_group in response["logGroups"]:
                            resources.append(CloudWatchLogGroup(self.session, region, log_group))
            pass
        else:
            response = log_client.describe_log_groups()
            for log_group in response["logGroups"]:
                resources.append(CloudWatchLogGroup(self.session, region, log_group))

        return resources
