from copy import Error
import os
import json
import boto3
import datetime as dt
import json


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
    # finding["UpdatedAt"] = f"{update_time}Z"
    finding["UpdatedAt"] = notification["turbot"]["createTimestamp"]
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

    # NOTE: Not sure we want the control ID
    # control_id = {"Type": "Control ID"}
    # control_id["Id"] = control["turbot"]["id"]
    # resources.append(control_id)

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
        old_control = notification["oldControl"]

        # Filter out new controls that have gone to okay
        if old_control["state"] == "tbd" and control["state"] == "ok":
            print(f"Ignoring notification: {notification}")
            continue

        control_id = control["turbot"]["id"]
        finding_id = create_finding_id(region, account_id, control_id)

        # a record has been found, is this a later version?
        if finding_id in records:
            exist_record_timestamp = records[finding_id]["turbot"]["createTimestamp"]
            new_record_timestamp = notification["turbot"]["createTimestamp"]

            exist_record_dt = dt.datetime.fromisoformat(exist_record_timestamp[:-1])
            new_record_dt = dt.datetime.fromisoformat(new_record_timestamp[:-1])

            if exist_record_dt < new_record_dt:
                print(f"Update record in record collection: {finding_id}")
                print(f"Notification: {notification}")
                records[finding_id] = notification
            else:
                print(f"A more updated version exists in record collection: {finding_id}")
                print(f"Notification: {notification}")
        else:
            print(f"Create record in record collection: {finding_id}")
            print(f"Notification: {notification}")
            records[finding_id] = notification

    print(f"Number of records to process: {len(records)}")
    return records


def find_existing_findings_map(client, records):
    ids = list(records.keys())
    finding_batch_size = 20
    filter = {"Id": []}

    found_findings = {}
    for id_batch in range(0, len(ids), finding_batch_size):
        filter["Id"] = []
        for id in ids[id_batch:id_batch+finding_batch_size]:
            entry = {
                "Value": f"{id}",
                "Comparison": "EQUALS"
            }

            filter["Id"].append(entry)

        response = client.get_findings(Filters=filter)
        findings = response["Findings"]
        print(f"Findings: {findings}")

        map_findings = {findings[i]["Id"]: findings[i] for i in range(0, len(findings))}
        found_findings = {**found_findings, **map_findings}

    return found_findings


def batch_resolve_findings(client, findings):
    workflow = {"Status": "RESOLVED"}
    response = client.batch_update_findings(FindingIdentifiers=findings,  Workflow=workflow)
    print(response)
    if len(response["UnprocessedFindings"]) > 0:
        print("Errors in processing resolve findings")
        return True

    print("Success processing resolve findings")
    return False


def batch_reopen_findings(client, findings):
    workflow = {"Status": "NEW"}
    response = client.batch_update_findings(FindingIdentifiers=findings,  Workflow=workflow)
    print(response)
    if len(response["UnprocessedFindings"]) > 0:
        print("Errors in processing reopen findings")
        return True

    print("Success processing reopen findings")
    return False


def batch_import_findings(client, findings):
    response = client.batch_import_findings(Findings=findings)
    print(response)
    if response["FailedCount"] > 0:
        print("Errors in processing import findings")
        return True

    print("Success processing import findings")
    return False


def lambda_handler(event, context):
    try:
        lambda_function_arn = context.invoked_function_arn.split(":")
        region = lambda_function_arn[3]
        account_id = lambda_function_arn[4]
        raw_records = event['Records']

        records = get_records(raw_records, region, account_id)

        client = boto3.client('securityhub')
        # existing_findings = find_existing_findings(client, list(records.keys()))
        existing_findings = find_existing_findings_map(client, records)

        product_arn = os.getenv("SECURITY_HUB_PRODUCT_ARN")

        reopen_findings = []
        resolved_findings = []
        insert_findings = []

        for key in records:
            notification = records[key]

            if key in existing_findings:
                # Check if findings is more recent, if so, ignore
                existing_finding_update_timestamp = existing_findings[key]["UpdatedAt"]
                notification_update_timestamp = notification["turbot"]["createTimestamp"]

                existing_finding_dt = dt.datetime.fromisoformat(existing_finding_update_timestamp[:-1])
                notification_dt = dt.datetime.fromisoformat(notification_update_timestamp[:-1])

                if notification_dt <= existing_finding_dt:
                    print(f"More recent finding for: {key} - ignoring update")
                    continue

                # Create an insert finding to update the update time
                insert_finding = create_insert_finding(key, product_arn, notification)
                insert_findings.append(insert_finding)

                update_finding = create_update_finding(key, product_arn)

                if notification["control"]["state"] == "alarm":
                    print(f"Update existing finding: {key} - adding to reopen queue")
                    reopen_findings.append(update_finding)
                else:
                    print(f"Update existing finding: {key} - adding to resolved queue")
                    resolved_findings.append(update_finding)
            else:
                # A notification that has resolved but not been recorded
                if notification["control"]["state"] in ["ok", "skipped", "tbd"]:
                    print(f"Ignoring finding: {key}")
                    continue

                print(f"Import new finding: {key}")
                insert_finding = create_insert_finding(key, product_arn, notification)
                insert_findings.append(insert_finding)

        # We need to update when we want to resolve a resolved finding
        partial_failure = False
        if len(insert_findings):
            partial_failure = partial_failure | batch_import_findings(client, insert_findings)

        if len(reopen_findings):
            partial_failure = partial_failure | batch_reopen_findings(client, reopen_findings)

        if len(resolved_findings):
            partial_failure = partial_failure | batch_resolve_findings(client, resolved_findings)

        if partial_failure == True:
            raise Error("Partial batch handled - retry")
    except Exception as e:
        print(f'Exception: {str(e)}')
        raise
