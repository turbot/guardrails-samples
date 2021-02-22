from .resource_service import ResourceService
from .resource import Resource
import logging


class EventRule(Resource):
    def __init__(self, session, region, event_rule) -> None:
        self.event_rule = event_rule
        self.region = region

        super().__init__(session)

    def details(self):
        return f'event/rule {self.event_rule["Name"]}'

    def delete(self, dry_run):
        logger = logging.getLogger(__name__)
        event_client = self.session.create_client('events', self.region)

        response = event_client.list_targets_by_rule(
            Rule=self.event_rule["Name"]
        )

        targets = []
        for target in response['Targets']:
            if not dry_run:
                targets.append(target['Id'])
            else:
                logger.info(f"Would remove event targets {target['Id']} for rule {self.event_rule['Name']}")

        if not dry_run:
            event_client.remove_targets(
                Rule=self.event_rule["Name"],
                Ids=targets
            )
            logger.info(f"Removed event targets {targets} for rule {self.event_rule['Name']}")

            event_client.delete_rule(Name=self.event_rule["Name"])
            logger.info(f"Deleted rule {self.event_rule['Name']}")
        else:
            logger.info(f"Would delete rule {self.event_rule['Name']}")


class EventsRuleResourceService(ResourceService):
    def __init__(self, session, recipe) -> None:
        super().__init__(session, recipe, "event", "rule")

    def get_all(self, region):
        name_prefix = ""
        for filter in self.recipe["filters"]:
            if filter["field"] == "NamePrefix":
                name_prefix = filter["value"]

        event_client = self.session.create_client('events', region)

        response = event_client.list_rules(NamePrefix=name_prefix)

        return [EventRule(self.session, region, rule) for rule in response["Rules"]]
