import time
from .resource_service import ResourceService
from .resource import Resource
import logging


class TurbotAccount(Resource):
    def __init__(self, session, v3_api, account_id) -> None:
        self.logger = logging.getLogger(__name__)
        self.v3_api = v3_api
        self.account_id = account_id
        super().__init__(session)

    def details(self):
        return f'turbot/account {self.account_id}'

    def rename(self, dry_run):
        self.v3_api.set_account_name_deleted(self.account_id, dry_run)
        if not dry_run:
            time.sleep(5)


class TurbotAccountResourceService(ResourceService):
    def __init__(self, session, v3_api, recipe, account_id) -> None:
        self.v3_api = v3_api
        self.account_id = account_id
        super().__init__(session, recipe, "turbot", "account", True)

    def get_all(self, region):
        return [TurbotAccount(self.session, self.v3_api, self.account_id)]
