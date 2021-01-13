from .resource_service import ResourceService
from .resource import Resource
import logging


class SnsTopic(Resource):
    def __init__(self, session, region, topic) -> None:
        self.topic = topic
        self.region = region
        self.sns_client = session.create_client('sns', self.region)
        self.logger = logging.getLogger(__name__)

        super().__init__(session)

    def details(self):
        return f'sns/topic {self.topic["TopicArn"]}'

    def delete(self, dry_run):
        if not dry_run:
            self.sns_client.delete_topic(TopicArn=self.topic["TopicArn"])
            self.logger.info(f"Removed topic {self.topic['TopicArn']}")
        else:
            self.logger.info(f"Would remove topic {self.topic['TopicArn']}")


class SnsTopicResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "sns", "topic")

    def get_all(self, region):
        sns_client = self.session.create_client('sns', region)
        response = sns_client.list_topics()

        resources = []
        for topic in response["Topics"]:
            for filter in self.recipe["filters"]:
                if filter["type"] == "endswith":
                    for value in filter["value"]:
                        if topic["TopicArn"].endswith(value):
                            resources.append(SnsTopic(self.session, region, topic))

        return resources
