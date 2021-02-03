from .resource_service import ResourceService
from .resource import Resource
import logging


class TurbotPolicies(Resource):
    def __init__(self, session, v3_api, account_urn) -> None:
        self.account_urn = account_urn
        self.v3_api = v3_api
        self.logger = logging.getLogger(__name__)
        super().__init__(session)

    def details(self):
        return f'turbot/policy {self.account_urn}'

    def disable(self, dry_run):
        self.v3_api.set_maintenance_window(self.account_urn, dry_run)
        self.v3_api.set_full_throttle(self.account_urn, dry_run)


class TurbotPoliciesResourceService(ResourceService):
    def __init__(self, session, v3_api, recipe, account_id, account_urn) -> None:
        self.v3_api = v3_api
        self.account_id = account_id
        self.account_urn = account_urn
        super().__init__(session, recipe, "turbot", "policy", True)

    def get_all(self, region):
        account_details = self.v3_api.get_account_details(self.account_id)

        if account_details["urn"] != self.account_urn:
            raise RuntimeError(
                f"Configured urn {self.account_urn} does not match expected url {account_details['urn']}")

        return [TurbotPolicies(self.session, self.v3_api, self.account_urn)]
