import time
import os
import boto3
import datetime as dt


class SecurityHub:
    def __init__(self, client, cache, product_arn) -> None:
        if not client:
            raise ValueError("Parameter `client` for class `SecurityHub` is missing")
        if not cache:
            raise ValueError("Parameter `cache` for class `SecurityHub` is missing")
        if not client:
            raise ValueError("Parameter `product_arn` for class `SecurityHub` is missing")

        self.client = client
        self.product_arn = product_arn
        self.cache = cache
        self.insert_findings = []
        self.reopen_findings = {}
        self.resolve_findings = {}

    @staticmethod
    def create(cache, account_id):
        start_time = time.perf_counter()
        print(f"[INFO] Started - Security Hub create client")
        product_arn = os.getenv("SECURITY_HUB_PRODUCT_ARN")
        if product_arn is None:
            raise RuntimeError("Environment variable `SECURITY_HUB_PRODUCT_ARN` is missing")

        role = os.getenv("SECURITY_HUB_ROLE")
        external_id = os.getenv("SECURITY_HUB_EXTERNAL_ID")

        if role:
            role_arn = f"arn:aws:iam::{account_id}:role/{role}"

            sts_connection = boto3.client('sts')
            if external_id:
                acct_b = sts_connection.assume_role(
                    RoleArn=role_arn,
                    ExternalId=external_id,
                    RoleSessionName="Turbot_Security_Hub_Integration"
                )
            else:
                acct_b = sts_connection.assume_role(
                    RoleArn=role_arn,
                    RoleSessionName="Turbot_Security_Hub_Integration"
                )

            access_key_id = acct_b['Credentials']['AccessKeyId']
            secret_access_key = acct_b['Credentials']['SecretAccessKey']
            session_token = acct_b['Credentials']['SessionToken']
        else:
            access_key_id = os.getenv("AWS_ACCESS_KEY_ID")
            secret_access_key = os.getenv("AWS_SECRET_ACCESS_KEY")
            session_token = os.getenv("AWS_SESSION_TOKEN")

        aws_client = boto3.client(
            'securityhub',
            aws_access_key_id=access_key_id,
            aws_secret_access_key=secret_access_key,
            aws_session_token=session_token,
        )

        end_time = time.perf_counter()
        print(f"[INFO] Completed - Security Hub create client - {end_time - start_time:0.4f} seconds")
        return SecurityHub(aws_client, cache, product_arn)

    def get_findings(self, ids):
        start_time = time.perf_counter()
        print(f"[INFO] Started - Get findings")
        batch_size = 20
        cache_found_id_map = {}

        for index in range(0, len(ids), batch_size):
            filter = {"Id": []}
            for id in ids[index:index+batch_size]:
                entry = {
                    "Value": f"{id}",
                    "Comparison": "EQUALS"
                }

                filter["Id"].append(entry)

            response = self.client.get_findings(Filters=filter)
            findings = response["Findings"]
            print(f"[INFO] Get Findings API result: {findings}")

            map_findings = {findings[i]["Id"]: findings[i]["UpdatedAt"] for i in range(0, len(findings))}
            cache_found_id_map = {**cache_found_id_map, **map_findings}

        end_time = time.perf_counter()
        print(f"[INFO] Completed - Get findings - {end_time - start_time:0.4f} seconds")

        return cache_found_id_map

    def process_findings(self):
        # We need to update when we want to resolve a resolved finding
        partial_failure = False
        if len(self.insert_findings):
            partial_failure = partial_failure | self.__batch_import_findings()

            print(f"[INFO] Importing {len(self.insert_findings)} findings")

        if len(self.reopen_findings):
            partial_failure = partial_failure | self.__batch_reopen_findings()

            print(f"[INFO] Reopened {len(self.reopen_findings)} findings")

        if len(self.resolve_findings):
            partial_failure = partial_failure | self.__batch_resolve_findings()

            print(f"[INFO] Resolved {len(self.resolve_findings)} findings")

        return partial_failure

    def reopen_finding(self, record):
        if not record:
            raise ValueError("Parameter `record` for class `SecurityHub` is missing")

        self.reopen_findings[record.id] = record.updated_timestamp
        print(f"[INFO] Adding record to reopen findings queue - {record.id} - {record.updated_timestamp}")

        self.insert_finding(record)

    def resolve_finding(self, record):
        if not record:
            raise ValueError("Parameter `record` for class `SecurityHub` is missing")

        self.reopen_findings[record.id] = record.updated_timestamp
        print(f"[INFO] Adding record to resolved findings queue - {record.id} - {record.updated_timestamp}")

        self.insert_finding(record)

    def insert_finding(self, record):
        if not record:
            raise ValueError("Parameter `record` for class `SecurityHub` is missing")

        finding = self.__create_insert_finding(record)

        self.insert_findings.append(finding)
        print(f"[INFO] Adding record to insert findings queue - {record.id} - {record.updated_timestamp}")

    def __create_update_finding(self, id):
        finding = {
            "Id": id,
            "ProductArn": self.product_arn
        }

        return finding

    def __create_insert_finding(self, record):
        print("[INFO] Starting - Create finding")
        # Common format
        finding = {
            "SchemaVersion": "2018-10-08",
            "Severity": {
                "Label": "HIGH",
                "Product": 80
            },
            "Compliance": {
                "Status": "WARNING"
            },
            "Types": ["Software and Configuration Checks/Governance/Out of Compliance"]
        }

        # Get update time
        update_time = dt.datetime.utcnow()
        update_time = update_time.isoformat()

        finding["Id"] = record.id
        finding["ProductArn"] = self.product_arn
        finding["AwsAccountId"] = record.account_id
        finding["CreatedAt"] = record.updated_timestamp
        finding["UpdatedAt"] = record.updated_timestamp
        finding["Description"] = record.description
        finding["Title"] = record.title

        resources = []

        for aka in record.akas:
            resource_aka = {
                "Type": "Resource AKA",
                "Id": aka
            }

            if record.partition:
                resource_aka["Partition"] = record.partition

            if record.region_name:
                resource_aka["Region"] = record.region_name

            resources.append(resource_aka)

        resource_id = {
            "Type": "Resource ID",
            "Id": record.resource_id
        }
        resources.append(resource_id)

        finding["Resources"] = resources

        generator_id = record.control_type.replace(" > ", "-").lower()
        finding["GeneratorId"] = f"arn:aws:securityhub:::ruleset/turbot/{generator_id}"

        print(f"[INFO] Completed - Create finding - {finding}")

        return finding

    def __batch_import_findings(self):
        start_time = time.perf_counter()
        print(f"[INFO] Started - Batch import findings")
        response = self.client.batch_import_findings(Findings=self.insert_findings)

        # update cache
        for finding in self.insert_findings:
            self.cache.set(finding["Id"], finding["UpdatedAt"])
            print(f"[INFO] Cache update - {finding['Id']} - {finding['UpdatedAt']}")
            pass

        failed_count = response["FailedCount"]
        handled_count = 0

        # Is this an account that is not managed by Sec Hub?
        for failed_finding in response["FailedFindings"]:
            if failed_finding["ErrorCode"] == "InvalidAccess":
                print(f"[WARN] Finding will not be processed - {failed_finding['ErrorMessage']}")
                handled_count += 1
            else:
                print(f"[WARN] Finding failed - will retry - {failed_finding}")

        end_time = time.perf_counter()
        if failed_count - handled_count > 0:
            print(f"[WARN] Completed with errors - Batch import findings - {end_time - start_time:0.4f} seconds")
            return True

        print(f"[INFO] Completed - Batch import findings - {end_time - start_time:0.4f} seconds")
        return False

    def __batch_update_findings(self, findings, status):
        start_time = time.perf_counter()
        status_lower = status.lower()
        print(f"[INFO] Started - Batch update findings with status {status_lower}")

        workflow = {"Status": status.upper()}
        batch = []

        for id in self.reopen_findings:
            cached_date = self.cache.get(id)
            if cached_date == None:
                batch.append(self.__create_update_finding(id))
                print(f"[INFO] Update finding with status {status_lower} - {id} - {findings[id]}")
            else:
                print(f"[INFO] Found cached entry - {id} - {cached_date}")

                findings_timestamp = dt.datetime.fromisoformat(findings[id][:-1])
                cache_findings_timestamp = dt.datetime.fromisoformat(cached_date[:-1])

                if cache_findings_timestamp <= findings_timestamp:
                    batch.append(self.__create_update_finding(id))
                    print(f"[INFO] Update finding with status {status_lower} - {id} - {findings[id]}")
                else:
                    print(
                        f"[INFO] Ignore finding with status {status_lower} - {id} - Cache date {cached_date} is more recent than finding {findings[id]}")

        failed_count = 0
        handled_count = 0

        if len(batch):
            response = self.client.batch_update_findings(FindingIdentifiers=batch,  Workflow=workflow)

            failed_count = len(response["UnprocessedFindings"])

            # Is this an account that is not managed by Sec Hub?
            for unprocessed_finding in response["UnprocessedFindings"]:
                if unprocessed_finding["ErrorCode"] == "FindingNotFound":
                    print(
                        f"[WARN] Batch update failed - Finding not found - {unprocessed_finding} - {unprocessed_finding['ErrorMessage']}")
                    handled_count += 1
                else:
                    print(f"[WARN] Batch update failed - Will retry - {unprocessed_finding}")

        end_time = time.perf_counter()
        if failed_count - handled_count > 0:
            print(
                f"[WARN] Completed with errors - Batch update findings with status {status_lower} - {end_time - start_time:0.4f} seconds")
            return True

        print(
            f"[INFO] Completed - Batch update findings with status {status_lower} - {end_time - start_time:0.4f} seconds")
        return False

    def __batch_reopen_findings(self):
        return self.__batch_update_findings(self.reopen_findings, "new")

    def __batch_resolve_findings(self):
        return self.__batch_update_findings(self.reopen_findings, "resolved")
