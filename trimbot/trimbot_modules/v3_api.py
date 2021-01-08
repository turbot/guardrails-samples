import urllib3
import requests
import json
import logging


class V3Api:
    def __init__(self, host, access_key, secret_access_key, verify_ssl) -> None:
        self.host = host
        self.access_key = access_key
        self.secret_access_key = secret_access_key
        self.verify_ssl = verify_ssl
        self.logger = logging.getLogger(__name__)
        super().__init__()

    def set_account_name_deleted(self, account_id, dry_run):
        if dry_run:
            self.logger.info(f"Would change name of {account_id} to '~ Deleted {account_id}'")
            return

        if not self.verify_ssl:
            urllib3.disable_warnings()

        url = f"{self.host}api/v3/accounts/{account_id}"
        data = {
            'title': f'~ Deleted {account_id}'
        }

        r = requests.patch(
            url,
            auth=(self.access_key, self.secret_access_key),
            verify=self.verify_ssl,
            data=json.dumps(data),
            headers={
                'content-type': "application/json;charset=UTF-8",
                'cache-control': "no-cache"
            }
        )

        r.close()
        if not r.ok:
            if r.status_code == 404:
                raise RuntimeError(f"Resource Not Found {account_id} on host {self.host}")
            else:
                error = json.loads(r.text)
                raise RuntimeError(
                    f"Unable to patch {account_id}\n{error['message']} with error code {error['code']}")

        self.logger.info(f"Changed name of {account_id} to '~ Deleted {account_id}'")

    def set_policy(self, resource_urn, policy_urn, value):
        if not self.verify_ssl:
            urllib3.disable_warnings()

        url = f"{self.host}api/v3/resources/{resource_urn}/policies/{policy_urn}?exception=true"
        data = {
            "requirement": "MUST",
            "notes": "",
            "expirationTimestamp": "",
            "value": value
        }

        r = requests.post(
            url,
            auth=(self.access_key, self.secret_access_key),
            verify=self.verify_ssl,
            data=json.dumps(data),
            headers={
                'content-type': "application/json;charset=UTF-8",
                'cache-control': "no-cache"
            }
        )

        if not r.ok and r.status_code != 409:
            r.close()
            if r.status_code == 404:
                raise RuntimeError(f"Resource Not Found {resource_urn} on host {self.host}")
            else:
                error = json.loads(r.text)
                raise RuntimeError(
                    f"Unable to set policy {policy_urn}\n{error['message']} with error code {error['code']}")

        r.close()

    def set_maintenance_window(self, resource_urn, dry_run):
        policy_value = "No changes"
        policy_urn = "Turbot:Environment:MaintenanceWindow"
        if not dry_run:
            self.set_policy(resource_urn, policy_urn, policy_value)
            self.logger.info(f"Set policy {policy_urn} to '{policy_value}'")
        else:
            self.logger.info(f"Would set policy {policy_urn} to '{policy_value}'")

    def set_full_throttle(self, resource_urn, dry_run):
        policy_value = "- { throttle: 100 }"
        policy_urn = "AWS:ResourceDiscoveryThrottleRules"
        if not dry_run:
            self.set_policy(resource_urn, policy_urn, policy_value)
            self.logger.info(f"Set policy {policy_urn} to '{policy_value}'")
        else:
            self.logger.info(f"Would set policy {policy_urn} to '{policy_value}'")

    def get_account_details(self, accountId):
        # Turn off SSL Warnings if not a valid ssl crt
        if not self.verify_ssl:
            urllib3.disable_warnings()

        url = f"{self.host}api/v3/accounts/{accountId}"

        r = requests.get(
            url,
            auth=(self.access_key, self.secret_access_key),
            verify=self.verify_ssl,
            headers={
                'content-type': "application/json;charset=UTF-8",
                'cache-control': "no-cache"
            }
        )

        if not r.ok:
            r.close()
            if r.status_code == 404:
                raise RuntimeError(f"Unable to find {accountId} on host {self.host}")
            else:
                error = json.loads(r.text)
                raise RuntimeError(
                    f"Unable to connect to host {self.host}\n{error['message']} with error code {error['code']}")

        result = r.json()
        r.close()

        return result
