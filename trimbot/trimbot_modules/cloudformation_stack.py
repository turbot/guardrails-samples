from .resource_service import ResourceService
from .resource import Resource
import logging


class CloudFormationStack(Resource):
    def __init__(self, session, stack, region) -> None:
        self.stack = stack
        self.region = region

        super().__init__(session)

    def details(self):
        return f'cloudformation/stack {self.stack["StackName"]}'

    def delete(self, dry_run):
        logger = logging.getLogger(__name__)
        cloudformation_client = self.session.create_client('cloudformation', self.region)

        if not dry_run:
            cloudformation_client.delete_stack(
                StackName=self.stack["StackName"]
            )

            logger.info(
                f"Deleted stack {self.stack['StackName']}")
        else:
            logger.info(f"Would delete stack {self.stack['StackName']}")


class CloudFormationStackResourceService(ResourceService):
    def __init__(self, session, recipe, account_id) -> None:
        self.account_id = account_id
        super().__init__(session, recipe, "cloudformation", "stack")

    def get_all(self, region):
        resources = []

        cloudformation_client = self.session.create_client('cloudformation', region)

        stack_status_filter = []
        for filter in self.recipe["filters"]:
            if "field" in filter and filter["field"] == "StackStatusFilter":
                stack_status_filter = filter["value"]

        response = cloudformation_client.list_stacks(
            StackStatusFilter=stack_status_filter
        )

        for stack in response["StackSummaries"]:
            for filter in self.recipe["filters"]:
                if "type" in filter and filter["type"] == "startswith":
                    if stack['StackName'].startswith(filter["value"]):
                        resources.append(CloudFormationStack(self.session, stack, region))
            if stack['StackName'].lower() == self.account_id.lower():
                resources.append(CloudFormationStack(self.session, stack, region))

        return resources
