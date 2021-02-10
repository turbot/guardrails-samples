import os
import json
import boto3
import datetime
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
    update_time = datetime.datetime.utcnow()
    update_time = update_time.isoformat()

    finding["ProductArn"] = product_arn
    finding["UpdatedAt"] = f"{update_time}Z"
    finding["AwsAccountId"] = aws_metadata["accountId"]
    finding["CreatedAt"] = notification["turbot"]["createTimestamp"]
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
    print(f"Number of records: {len(raw_records)}")
    records = {}
    for raw_record in raw_records:
        json_body = json.loads(raw_record['body'])
        notification = json.loads(json_body['Message'])

        control = notification["control"]
        old_control = notification["oldControl"]

        # Filter out new controls that have gone to okay
        if old_control["state"] == "tbd" and control["state"] == "ok":
            continue

        control_id = control["turbot"]["id"]
        finding_id = create_finding_id(region, account_id, control_id)

        records[finding_id] = notification

    return records


def get_findings_id(finding):
    return finding["Id"]


def find_existing_findings(client, ids):
    filter = {
        "Id": [],
    }

    filter_ids = filter["Id"]
    for id in ids:
        entry = {
            "Value": f"{id}",
            "Comparison": "EQUALS"
        }

        filter_ids.append(entry)

    response = client.get_findings(Filters=filter)
    findings = response["Findings"]

    result = map(get_findings_id, findings)
    return list(result)


def batch_resolve_findings(client, findings):
    workflow = {"Status": "RESOLVED"}
    response = client.batch_update_findings(FindingIdentifiers=findings,  Workflow=workflow)
    print(response)


def batch_reopen_findings(client, findings):
    workflow = {"Status": "NEW"}
    response = client.batch_update_findings(FindingIdentifiers=findings,  Workflow=workflow)
    print(response)


def batch_import_findings(client, findings):
    response = client.batch_import_findings(Findings=findings)
    print(response)


def lambda_handler(event, context):
    try:
        lambda_function_arn = context.invoked_function_arn.split(":")
        region = lambda_function_arn[3]
        account_id = lambda_function_arn[4]
        raw_records = event['Records']

        records = get_records(raw_records, region, account_id)

        client = boto3.client('securityhub')
        existing_findings = find_existing_findings(client, list(records.keys()))

        product_arn = os.getenv("SECURITY_HUB_PRODUCT_ARN")

        reopen_findings = []
        resolved_findings = []
        insert_findings = []

        for key in records:
            if key in existing_findings:
                print(f"Update finding: {key}")

                # Create an insert finding to update the update time
                insert_finding = create_insert_finding(key, product_arn, records[key])
                insert_findings.append(insert_finding)

                update_finding = create_update_finding(key, product_arn)
                notification = records[key]

                if notification["control"]["state"] == "alarm":
                    reopen_findings.append(update_finding)
                else:
                    resolved_findings.append(update_finding)
            else:
                notification = records[key]

                # A notification that has resolved but not been recorded
                if notification["control"]["state"] in ["ok", "skipped", "tbd"]:
                    continue

                print(f"Adding finding: {key}")
                insert_finding = create_insert_finding(key, product_arn, records[key])
                insert_findings.append(insert_finding)

        # We need to update when we want to resolve a resolved finding
        if len(reopen_findings):
            batch_reopen_findings(client, reopen_findings)

        if len(resolved_findings):
            batch_resolve_findings(client, resolved_findings)

        if len(insert_findings):
            batch_import_findings(client, insert_findings)
    except Exception as e:
        print(f'Exception: {str(e)}')
        raise
