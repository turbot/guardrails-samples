from .resource_service import ResourceService
from .resource import Resource
import logging


class CloudTrailTrail(Resource):
    def __init__(self, session, trail, region) -> None:
        self.trail = trail
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.cloudtrail_client = session.create_client('cloudtrail', self.region)

        super().__init__(session)

    def details(self):
        return f'cloudtrail/cloudtrail {self.trail["TrailARN"]}'

    def delete(self, dry_run):
        if not dry_run:
            self.cloudtrail_client.delete_trail(
                Name=self.trail["TrailARN"]
            )
            self.logger.info(f"Deleted trail {self.trail['TrailARN']}")
        else:
            self.logger.info(f"Would delete trail {self.trail['TrailARN']}")


class CloudTrailTrailResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "cloudformation", "stack")

    def get_all(self, region):
        cloudtrail_client = self.session.create_client('cloudtrail', region)

        response = cloudtrail_client.list_trails()

        resources = []
        for trail in response["Trails"]:
            arn = trail["TrailARN"].split("/")

            if trail["HomeRegion"] == region and arn[1].startswith("turbot-"):
                resources.append(CloudTrailTrail(self.session, trail, region))
            # for filter in self.recipe["filters"]:
            #     if "type" in filter and filter["type"] == "startswith":
            #         if trail['StackName'].startswith(filter["value"]):
            #             resources.append(CloudTrailTrail(self.session, trail, region))
            # if trail['StackName'].lower() == self.account_id.lower():
            #     resources.append(CloudTrailTrail(self.session, trail, region))

        return resources
