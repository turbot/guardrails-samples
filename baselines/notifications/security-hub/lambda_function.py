import os
import json
import boto3
import datetime as dt
import json
from pymemcache.client import base


def create_update_finding(id, product_arn):
    finding = {
        "Id": id,
        "ProductArn": product_arn
    }

    return finding


def create_insert_finding(id, product_arn, notification):
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

    # Break message into parts
    control = notification["control"]
    resource = control["resource"]

    aws_metadata = resource["metadata"]["aws"]

    # Get update time
    update_time = dt.datetime.utcnow()
    update_time = update_time.isoformat()

    finding["ProductArn"] = product_arn
    finding["AwsAccountId"] = aws_metadata["accountId"]
    finding["CreatedAt"] = notification["turbot"]["createTimestamp"]
    finding["UpdatedAt"] = notification["turbot"]["createTimestamp"]

    finding["Description"] = "None reason given"
    if control["reason"] != None:
        finding["Description"] = control["reason"]

    resources = []

    for aka in resource["akas"]:
        resource_aka = {"Type": "Resource AKA"}
        resource_aka["Id"] = aka
        if "partition" in aws_metadata:
            resource_aka["Partition"] = aws_metadata["partition"]

        if "regionName" in aws_metadata:
            resource_aka["Region"] = aws_metadata["regionName"]

        resources.append(resource_aka)

    resource_id = {"Type": "Resource ID"}
    resource_id["Id"] = resource["turbot"]["id"]
    resources.append(resource_id)

    control_type = control["type"]["trunk"]["title"]

    state = control["state"]

    if state == "ok":
        old_control_state = notification["oldControl"]["state"]
        finding["Title"] = f"{old_control_state.capitalize()} - {control_type}"
    else:
        finding["Title"] = f"{state.capitalize()} - {control_type}"

    finding["Resources"] = resources

    generator_id = control_type.replace(" > ", "-").lower()
    finding["GeneratorId"] = f"arn:aws:securityhub:::ruleset/turbot/{generator_id}"
    finding["Id"] = id

    print(f"Created finding: {finding}")

    return finding


def create_finding_id(region, account_id, control_id):
    return f"arn:aws:securityhub:{region}:{account_id}:turbot/{control_id}"


def get_records(raw_records, region, account_id):
    print(f"Number of raw records received: {len(raw_records)}")
    records = {}

    for raw_record in raw_records:
        json_body = json.loads(raw_record['body'])
        notification = json.loads(json_body['Message'])

        control = notification["control"]
        control_id = control["turbot"]["id"]
        finding_id = create_finding_id(region, account_id, control_id)

        notification_type = notification["notificationType"]
        if notification_type != "control_updated":
            print(f"Record ignored - {notification_type} - is not handled currently")
            continue

        resource_metadata = control["resource"]["metadata"]
        if "aws" not in resource_metadata:
            print("Record ignored - cloud provider not AWS")
            continue

        new_record_timestamp = notification["turbot"]["createTimestamp"]

        print(f"Raw record - {finding_id} - {new_record_timestamp}")

        if finding_id in records:
            exist_record_timestamp = records[finding_id]["turbot"]["createTimestamp"]

            exist_record_dt = dt.datetime.fromisoformat(exist_record_timestamp[:-1])
            new_record_dt = dt.datetime.fromisoformat(new_record_timestamp[:-1])

            if exist_record_dt <= new_record_dt:
                print(f"Update record (record collection) - {finding_id} - {new_record_timestamp}")
                print(f"Notification: {notification}")
                records[finding_id] = notification
            else:
                print(f"Ignore update record (record collection) - out of date - {finding_id} - {new_record_timestamp}")
                print(f"Notification: {notification}")
        else:
            print(f"Create record (record collection) - {finding_id} - {new_record_timestamp}")
            print(f"Notification: {notification}")
            records[finding_id] = notification

    print(f"Number of records to process: {len(records)}")
    return records

    endpoint = os.getenv("MEMCACHED_CONFIGURATION_ENDPOINT")
    if endpoint:
        return base.Client(endpoint)

    return None


def create_cache():
    client = None
    endpoint = os.getenv("MEMCACHED_CONFIGURATION_ENDPOINT")
    if endpoint:
        client = base.Client(endpoint)

    return Cache(client)


class Cache:
    def __init__(self, client) -> None:
        self.client = client
        pass

    def get(self, key):
        return self.client.get(key)

    def set(self, key, value):
        return self.client.set(key, value)

    def get_cached_findings(self, ids):
        cache_found_id_map = {}

        if self.client == None:
            return cache_found_id_map, ids

        cache_missed_id_list = []

        for id in ids:
            last_updated_ts = self.client.get(id)
            if last_updated_ts == None:
                cache_missed_id_list.append(id)
            else:
                last_updated_ts = last_updated_ts.decode("UTF-8")
                print(f"Cache hit - Adding id cache found id map - {id} - {last_updated_ts}")
                cache_found_id_map[id] = last_updated_ts

        return cache_found_id_map, cache_missed_id_list


class SecurityHub:
    def __init__(self, client) -> None:
        self.client = client
        pass

    def get_findings(self, ids):
        batch_size = 20

        for index in range(0, len(ids), batch_size):
            filter["Id"] = []
            for id in ids[index:index+batch_size]:
                entry = {
                    "Value": f"{id}",
                    "Comparison": "EQUALS"
                }

                filter["Id"].append(entry)

            response = self.client.get_findings(Filters=filter)
            findings = response["Findings"]
            print(f"Get Findings API result: {findings}")

            map_findings = {findings[i]["Id"]: findings[i]["UpdatedAt"] for i in range(0, len(findings))}
            cache_found_id_map = {**cache_found_id_map, **map_findings}


def find_existing_findings_map(aws_client, cache_client, records):
    ids = list(records.keys())

    # first look in the cache if there is one present
    cache_found_id_map = {}
    cache_missed_id_list = []

    cache_found_id_map, cache_missed_id_list = cache_client.get_cached_findings(ids)

    security_hub = SecurityHub()
    security_hub.get_findings(cache_missed_id_list)

    # check security hub for any missed
    finding_batch_size = 20
    filter = {"Id": []}

    for id_batch in range(0, len(cache_missed_id_list), finding_batch_size):
        filter["Id"] = []
        for id in cache_missed_id_list[id_batch:id_batch+finding_batch_size]:
            entry = {
                "Value": f"{id}",
                "Comparison": "EQUALS"
            }

            filter["Id"].append(entry)

        response = aws_client.get_findings(Filters=filter)
        findings = response["Findings"]
        print(f"Get Findings API result: {findings}")

        map_findings = {findings[i]["Id"]: findings[i]["UpdatedAt"] for i in range(0, len(findings))}
        cache_found_id_map = {**cache_found_id_map, **map_findings}

    return cache_found_id_map


def is_more_recent_or_same(date, reference_date):
    current = dt.datetime.fromisoformat(date[:-1])
    reference = dt.datetime.fromisoformat(reference_date[:-1])

    return reference <= current


# TODO: Code duplication with below function
def batch_resolve_findings(client, cache_client, findings, product_arn):
    workflow = {"Status": "RESOLVED"}

    # recheck cache
    batch = []
    if cache_client:
        for id in findings:
            cached_date = cache_client.get(id)
            if cached_date == None:
                batch.append(create_update_finding(id, product_arn))
                print(f"Resolve {id} - {findings[id]}")
            else:
                print(f"Cache hit - Found entry - {id} - {cached_date.decode('UTF-8')}")
                if is_more_recent_or_same(findings[id], cached_date.decode("UTF-8")):
                    batch.append(create_update_finding(id, product_arn))
                    print(f"Resolve {id} - {findings[id]}")
                else:
                    print(f"More recent update - no need to resolve finding - {id} - {findings[id]}")
    else:
        for id in findings:
            batch.append(create_update_finding(id, product_arn))
            print(f"Resolve {id}")

    if len(batch):
        response = client.batch_update_findings(FindingIdentifiers=batch,  Workflow=workflow)

        failed_count = len(response["UnprocessedFindings"])
        handled_count = 0

        # Is this an account that is not managed by Sec Hub?
        for unprocessed_finding in response["UnprocessedFindings"]:
            if unprocessed_finding["ErrorCode"] == "FindingNotFound":
                print(f"No finding to resolve - {unprocessed_finding['ErrorMessage']}")
                handled_count += 1
            else:
                print(f"Finding failed - will retry - {unprocessed_finding}")

        if failed_count - handled_count > 0:
            print("Batch resolve findings - Completed with errors")
            return True

    print("Batch resolve findings - Completed successfully")
    return False


def batch_reopen_findings(client, cache_client, findings, product_arn):
    workflow = {"Status": "NEW"}

    # recheck cache
    batch = []
    if cache_client:
        for id in findings:
            cached_date = cache_client.get(id)
            if cached_date == None:
                batch.append(create_update_finding(id, product_arn))
                print(f"Reopen - {id} - {findings[id]}")
            else:
                print(f"Cache hit - Found entry - {id} - {cached_date.decode('UTF-8')}")
                if is_more_recent_or_same(findings[id], cached_date.decode("UTF-8")):
                    batch.append(create_update_finding(id, product_arn))
                    print(f"Reopen {id}")
                else:
                    print(f"More recent update - no need to reopen finding - {id} - {findings[id]}")
    else:
        for id in findings:
            batch.append(create_update_finding(id, product_arn))
            print(f"Reopen {id} - {findings[id]}")

    if len(batch):
        response = client.batch_update_findings(FindingIdentifiers=batch,  Workflow=workflow)

        failed_count = len(response["UnprocessedFindings"])
        handled_count = 0

        # Is this an account that is not managed by Sec Hub?
        for unprocessed_finding in response["UnprocessedFindings"]:
            if unprocessed_finding["ErrorCode"] == "FindingNotFound":
                print(f"No finding to reopen - {unprocessed_finding['ErrorMessage']}")
                handled_count += 1
            else:
                print(f"Finding failed - will retry - {unprocessed_finding}")

        if failed_count - handled_count > 0:
            print("Batch reopen findings - Completed with errors")
            return True

    print("Batch reopen findings - Completed successfully")
    return False


def batch_import_findings(client, cache_client, findings):
    response = client.batch_import_findings(Findings=findings)

    # update cache
    for finding in findings:
        cache_client.set(finding["Id"], finding["UpdatedAt"])
        print(f"Cache update - {finding['Id']} - {finding['UpdatedAt']}")
        pass

    failed_count = response["FailedCount"]
    handled_count = 0

    # Is this an account that is not managed by Sec Hub?
    for failed_finding in response["FailedFindings"]:
        if failed_finding["ErrorCode"] == "InvalidAccess":
            print(f"Finding will not be processed - {failed_finding['ErrorMessage']}")
            handled_count += 1
        else:
            print(f"Finding failed - will retry - {failed_finding}")

    if failed_count - handled_count > 0:
        print("Batch import findings - Completed with errors")
        return True

    print("Batch import findings - Completed successfully")
    return False


def create_cache_client():
    endpoint = os.getenv("MEMCACHED_CONFIGURATION_ENDPOINT")
    if endpoint:
        return base.Client(endpoint)

    return None


def get_account_id_and_region(context):
    lambda_function_arn = context.invoked_function_arn.split(":")
    region = lambda_function_arn[3]
    account_id = lambda_function_arn[4]
    return account_id, region


class RecordConsolidator:
    def __init__(self, raw_records, account_id, region) -> None:
        self.raw_records = raw_records
        self.region = region
        self.account_id = account_id
        pass

    def consolidate(self):
        return get_records(self.raw_records, self.region, self.account_id)


def lambda_handler(event, context):
    try:
        account_id, region = get_account_id_and_region(context)

        record_consolidator = RecordConsolidator(event['Records'], account_id, region)
        cache = create_cache()
        records = record_consolidator.consolidate()

        aws_client = boto3.client('securityhub')
        existing_findings = find_existing_findings_map(aws_client, cache, records)

        product_arn = os.getenv("SECURITY_HUB_PRODUCT_ARN")

        reopen_findings = {}
        resolved_findings = {}
        insert_findings = []

        for key in records:
            notification = records[key]

            notification_update_timestamp = notification["turbot"]["createTimestamp"]

            if key in existing_findings:
                # Check if findings is more recent, if so, ignore
                existing_finding_update_timestamp = existing_findings[key]

                existing_finding_dt = dt.datetime.fromisoformat(existing_finding_update_timestamp[:-1])
                notification_dt = dt.datetime.fromisoformat(notification_update_timestamp[:-1])

                if notification_dt < existing_finding_dt:
                    print(f"Ingoring record - More recent update - {key} - {notification_update_timestamp}")
                    continue

                # Create an insert finding to update the update time
                insert_finding = create_insert_finding(key, product_arn, notification)
                if insert_finding == None:
                    print("[ERROR] Cloud provider of notification was not for AWS")
                    continue

                insert_findings.append(insert_finding)

                if notification["control"]["state"] == "alarm":
                    print(f"Update record - adding to reopen queue - {key} - {notification_update_timestamp}")
                    reopen_findings[key] = notification_update_timestamp
                else:
                    print(f"Update record - adding to resolved queue - {key} - {notification_update_timestamp}")
                    resolved_findings[key] = notification_update_timestamp
            else:
                # A notification that has resolved but not been recorded
                if notification["control"]["state"] in ["ok", "skipped", "tbd"]:
                    print(f"Ignoring record - record is in a healthy state - {key}")
                    continue

                print(f"Create record - {key} - {notification_update_timestamp}")
                insert_finding = create_insert_finding(key, product_arn, notification)
                insert_findings.append(insert_finding)

        # We need to update when we want to resolve a resolved finding
        partial_failure = False
        if len(insert_findings):
            partial_failure = partial_failure | batch_import_findings(aws_client, cache, insert_findings)

        print(f"Updating {len(insert_findings)} findings")

        if len(reopen_findings):
            partial_failure = partial_failure | batch_reopen_findings(
                aws_client,
                cache,
                reopen_findings,
                product_arn
            )

            print(f"Reopened {len(reopen_findings)} findings")

        if len(resolved_findings):
            partial_failure = partial_failure | batch_resolve_findings(
                aws_client,
                cache,
                resolved_findings,
                product_arn
            )

            print(f"Resolved {len(resolved_findings)} findings")

        if partial_failure == True:
            raise RuntimeError("Partial batch handled - retry")

        print("Completed - No Errors")
    except Exception as e:
        print(f'Exception: {str(e)}')
        print("Completed - With Errors")
        raise
