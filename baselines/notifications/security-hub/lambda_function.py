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
    finding_batch_size = 20
    filter = {"Id": []}
    filter_ids = filter["Id"]

    found_findings = []

    for id_batch in range(0, len(ids), finding_batch_size):
        for id in ids[id_batch:id_batch+finding_batch_size]:
            entry = {
                "Value": f"{id}",
                "Comparison": "EQUALS"
            }

            filter_ids.append(entry)

        response = client.get_findings(Filters=filter)
        findings = response["Findings"]

        map_findings = map(get_findings_id, findings)
        found_findings = found_findings + list(map_findings)

    return found_findings


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


# For debugging
# class Context:
#     def __init__(self) -> None:
#         self.invoked_function_arn = "arn:aws:lambda:eu-west-2:210125595713:function:LambdaFunctionName"
#         pass


# context = Context()

# event = {
#     "Records": [
#         {
#             "messageId": "178b8a4b-59cb-438c-8c46-1d2dab72d879",
#             "receiptHandle": "AQEBLpAUJdvZ02EGdOk2nlqhxs0XMBGA07j5p9XNPjIjUlv078pBGhhLfFc8HrdB/dsYFEzjVTT1K35RmPWh3PVq8YySV7KusRmqE4n49TPTw2hKajfZZgbAxdUsz+Z+j3vfawiwcen3vOpbWOTL3OvvCOICScRXFKb2XgqmMOsMdNVz1ZKSVFhFXhONWILbMbVPE9roBCJVnDMpRPRa/66LK2Cm7PzAqI3Klphg0s/K1hhyTKz/bFf3iQcjk5C4TRXQiMU8yh4xDK8M5SgCkClU35LnO0y7ILwbawJg0NwGOEXa0+enN8mmi70vCGGDKPQNAj94uJD3glJHB+HAxpThwrYlRkdQhYvUOtOkdUZo2t8kGMSLsXTh0CY+k606gdCEZix73Bvj8EkYBXLYWobQNDtguQA6vw5Hv6VeLU21Etw=",
#             "body": "{\n \"Type\" : \"Notification\",\n \"MessageId\" : \"686c0fa2-fb77-5a75-b8a5-573fbc819392\",\n \"TopicArn\" : \"arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic\",\n \"Subject\" : \"[punisher-turbot] Control Approved updated by Turbot Identity\",\n \"Message\" : \"{\\\"notificationType\\\":\\\"control_updated\\\",\\\"actor\\\":{\\\"identity\\\":{\\\"picture\\\":\\\"https://www.gravatar.com/avatar/cb9ff8606c24daf9cda1d82615bd7a8e\\\",\\\"turbot\\\":{\\\"title\\\":\\\"Turbot Identity\\\",\\\"id\\\":\\\"173249891011852\\\"}}},\\\"turbot\\\":{\\\"type\\\":null,\\\"controlId\\\":\\\"209109092347761\\\",\\\"controlOldVersionId\\\":\\\"215954570798519\\\",\\\"controlNewVersionId\\\":\\\"215954980760708\\\",\\\"createTimestamp\\\":\\\"2021-02-10T02:32:15.897Z\\\"},\\\"control\\\":{\\\"state\\\":\\\"alarm\\\",\\\"reason\\\":\\\"Not approved\\\",\\\"details\\\":[{\\\"key\\\":\\\"Usage\\\",\\\"value\\\":\\\"Not approved\\\"},{\\\"key\\\":\\\"Regions\\\",\\\"value\\\":\\\"Approved\\\"},{\\\"key\\\":\\\"Budget\\\",\\\"value\\\":\\\"Skipped\\\"},{\\\"key\\\":\\\"RESULT\\\",\\\"value\\\":\\\"Not approved\\\"}],\\\"type\\\":{\\\"trunk\\\":{\\\"title\\\":\\\"AWS > S3 > Bucket > Approved\\\"}},\\\"turbot\\\":{\\\"id\\\":\\\"209109092347761\\\"},\\\"resource\\\":{\\\"akas\\\":[\\\"arn:aws:s3:::turbot-210125595713-ca-central-1\\\"],\\\"metadata\\\":{\\\"aws\\\":{\\\"accountId\\\":\\\"210125595713\\\",\\\"partition\\\":\\\"aws\\\",\\\"regionName\\\":\\\"ca-central-1\\\"},\\\"createTimestamp\\\":\\\"2020-11-24T17:03:29.000Z\\\"},\\\"title\\\":null,\\\"turbot\\\":{\\\"id\\\":\\\"209109091574205\\\"}}},\\\"oldControl\\\":{\\\"state\\\":\\\"ok\\\",\\\"turbot\\\":{\\\"id\\\":\\\"209109092347761\\\"}}}\",\n \"Timestamp\" : \"2021-02-10T02:32:22.339Z\",\n \"SignatureVersion\" : \"1\",\n \"Signature\" : \"kvmhEs8+mljhGrS/KhmK5XmT/5dqaaEzV3QDOT0o0gY6Gfp6F2dDtGaGq/4Tj/C7Kk/K+60d1gPglX3GTYVgpcp6xflOBXzl9RVFh30GnUZFg2X0EgfGrH7N2zIQwT+ZdJYUKyDAKL2x3WzG90Y6LGq9+PzkAHs550TeID0DxrCnLePLkG+W0FvqYslgmHM//swtEIYPXsdwOB1ig5s90D5xMcrEpLsamBtdsWYYxHq1LQx4rluno2+exIN3pv4WigM7jUKgGHKAeMFlujv65e0DLmNtdC3eS63b5zz9RKdt9mYiXmsrZ7g2p2MnYGowZYz6wv0GJ82VM2obzvo5zg==\",\n \"SigningCertURL\" : \"https://sns.eu-west-2.amazonaws.com/SimpleNotificationService-010a507c1833636cd94bdb98bd93083a.pem\",\n \"UnsubscribeURL\" : \"https://sns.eu-west-2.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic:b2a70670-64b3-48cb-af6a-3effb15abcfa\"\n}",
#             "attributes": {
#                 "ApproximateReceiveCount": "6",
#                 "SentTimestamp": "1612924342378",
#                 "SenderId": "AIDAIVEA3AGEU7NF6DRAG",
#                 "ApproximateFirstReceiveTimestamp": "1612924342378"
#             },
#             "messageAttributes": {},
#             "md5OfMessageAttributes": None,
#             "md5OfBody": "5546e09f09c9dd765978ee50c48e7848",
#             "eventSource": "aws:sqs",
#             "eventSourceARN": "arn:aws:sqs:eu-west-2:210125595713:turbot-update-notification-queue",
#             "awsRegion": "eu-west-2"
#         },
#         {
#             "messageId": "b93f890f-6055-4658-8a1f-5a0b1278cdbe",
#             "receiptHandle": "AQEBmsLfaL2Ii0J62vXs3zEoGe/7FrogZPOarfQ4SbQ4aY9nwj3U3m0A+POBDz7ifS1i4cfzgolQ2T6m5IkQZmtyY3/giBKLRhjmOt4gXxCXcOjFI9Szk7zr036S9ll8pHrgRBpx7GibON7f3iQgmHyDuKbfmPqJ9/ir7E0B9ChEStCSlqaBkzTiGvcpE6sYZ08cxoHhOl8Kb8t5THwL3MRGch7jD6uAV+0LUSOQS8UHjupjOTYtMTymLSJDOwm+vXwSn1dL2mRuvUyeemS5905KDyWiA2l+I3VYXMoWivBc78DJ81ZvCwKJRg6Sj7E/ojq3P9FL5qTYWmDC2mzkaMeWI6m+WykDB7CPEovEaraP64m2UYDXopGOu7Lek/De5AHvjVACOY9XozdfJsi5E/cVd23acVMrNw7y2OgKoEvoZHs=",
#             "body": "{\n \"Type\" : \"Notification\",\n \"MessageId\" : \"2fbce329-734a-5164-8419-bbb434bd9bbb\",\n \"TopicArn\" : \"arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic\",\n \"Subject\" : \"[punisher-turbot] Control Approved updated by Turbot Identity\",\n \"Message\" : \"{\\\"notificationType\\\":\\\"control_updated\\\",\\\"actor\\\":{\\\"identity\\\":{\\\"picture\\\":\\\"https://www.gravatar.com/avatar/cb9ff8606c24daf9cda1d82615bd7a8e\\\",\\\"turbot\\\":{\\\"title\\\":\\\"Turbot Identity\\\",\\\"id\\\":\\\"173249891011852\\\"}}},\\\"turbot\\\":{\\\"type\\\":null,\\\"controlId\\\":\\\"209109091728900\\\",\\\"controlOldVersionId\\\":\\\"215954570851779\\\",\\\"controlNewVersionId\\\":\\\"215954980403275\\\",\\\"createTimestamp\\\":\\\"2021-02-10T02:32:15.547Z\\\"},\\\"control\\\":{\\\"state\\\":\\\"alarm\\\",\\\"reason\\\":\\\"Not approved\\\",\\\"details\\\":[{\\\"key\\\":\\\"Usage\\\",\\\"value\\\":\\\"Not approved\\\"},{\\\"key\\\":\\\"Regions\\\",\\\"value\\\":\\\"Approved\\\"},{\\\"key\\\":\\\"Budget\\\",\\\"value\\\":\\\"Skipped\\\"},{\\\"key\\\":\\\"RESULT\\\",\\\"value\\\":\\\"Not approved\\\"}],\\\"type\\\":{\\\"trunk\\\":{\\\"title\\\":\\\"AWS > S3 > Bucket > Approved\\\"}},\\\"turbot\\\":{\\\"id\\\":\\\"209109091728900\\\"},\\\"resource\\\":{\\\"akas\\\":[\\\"arn:aws:s3:::turbot-210125595713-eu-west-3\\\"],\\\"metadata\\\":{\\\"aws\\\":{\\\"accountId\\\":\\\"210125595713\\\",\\\"partition\\\":\\\"aws\\\",\\\"regionName\\\":\\\"eu-west-3\\\"},\\\"createTimestamp\\\":\\\"2020-11-24T17:03:53.000Z\\\"},\\\"title\\\":null,\\\"turbot\\\":{\\\"id\\\":\\\"209109091263819\\\"}}},\\\"oldControl\\\":{\\\"state\\\":\\\"ok\\\",\\\"turbot\\\":{\\\"id\\\":\\\"209109091728900\\\"}}}\",\n \"Timestamp\" : \"2021-02-10T02:32:23.409Z\",\n \"SignatureVersion\" : \"1\",\n \"Signature\" : \"dtv1iefd3fu8/MwC66gKkOgfVSnndmANygAsvo144pTE5WmC93dCXtOYsCwSM19SWvQX3zS51MZwCMrPLXS2iaaDq4uGvpZpmR6ixd9o0XIibDSoD+ZWebAlvKZipHtj+b/H/mLVwH65UE7sSt1Pc9mE3VBuZFdtEqRBwuihmUDnTHnhAF4P7e8ZxiWeHKzOxSPHlIX21506vjR6Gs1MGpwZdbVnKKBR9OyvX2TSR29Gox9FChImrz2PmDgTTIcX4oU4jR5z4w70Uz5rckgw9K3lgkcS49U9PWQBVnpTN0CG/oxmZ3D/W3QB5o3g0FmozvRUci5LCDEXT9mVBGsl5g==\",\n \"SigningCertURL\" : \"https://sns.eu-west-2.amazonaws.com/SimpleNotificationService-010a507c1833636cd94bdb98bd93083a.pem\",\n \"UnsubscribeURL\" : \"https://sns.eu-west-2.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic:b2a70670-64b3-48cb-af6a-3effb15abcfa\"\n}",
#             "attributes": {
#                 "ApproximateReceiveCount": "6",
#                 "SentTimestamp": "1612924343439",
#                 "SenderId": "AIDAIVEA3AGEU7NF6DRAG",
#                 "ApproximateFirstReceiveTimestamp": "1612924343439"
#             },
#             "messageAttributes": {},
#             "md5OfMessageAttributes": None,
#             "md5OfBody": "989515bb4933e54308c67f86cfb49471",
#             "eventSource": "aws:sqs",
#             "eventSourceARN": "arn:aws:sqs:eu-west-2:210125595713:turbot-update-notification-queue",
#             "awsRegion": "eu-west-2"
#         },
#         {
#             "messageId": "ffe02e46-b4f6-4fd6-91ac-1f17eb3a4aeb",
#             "receiptHandle": "AQEB3yhtNAqntrz5WxF6QTL7LgHpvVbK3eQiri9zW/24pK8hps/xI0f5Hgb4XVPYMYn6cMH7aZ3KuRYmS3qBvZDfAlsnAW9LqCfluvlCrK8aAsa3nwJZn8QdARmVpbNjWVToB9VFrWMcLTCCVmb9vPrgVDhECTRrNPiAL+iwB7fo0Ub4dXQSs3D/pazsJIH66dj/h+JPUnLdQlazeEEUXj+dy+4t+Eg2BggC9CH3xcyfvB9j4NdmpR47JTekAeIL0vNT1PvTIEnnwTVgGPCmyGSnBsXOQDS4xFr0Gb5OmfKnuSU1H3z1+RlR1ex5dO2DVRE5iWUbRdMpJGeR/Lc5pWk7K3h5B5mKMrtE2F+uCIBVbXAw89/MLY5c3tH2aAxoNFqb2NNeeSFAqgSrQurHXBfABH9ZjDhdmWsP7Vst4EhiEds=",
#             "body": "{\n \"Type\" : \"Notification\",\n \"MessageId\" : \"fdd62fb1-9a97-5163-bd5f-772cdd686286\",\n \"TopicArn\" : \"arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic\",\n \"Subject\" : \"[punisher-turbot] Control Approved updated by Turbot Identity\",\n \"Message\" : \"{\\\"notificationType\\\":\\\"control_updated\\\",\\\"actor\\\":{\\\"identity\\\":{\\\"picture\\\":\\\"https://www.gravatar.com/avatar/cb9ff8606c24daf9cda1d82615bd7a8e\\\",\\\"turbot\\\":{\\\"title\\\":\\\"Turbot Identity\\\",\\\"id\\\":\\\"173249891011852\\\"}}},\\\"turbot\\\":{\\\"type\\\":null,\\\"controlId\\\":\\\"213197618618065\\\",\\\"controlOldVersionId\\\":\\\"215954571395675\\\",\\\"controlNewVersionId\\\":\\\"215954993455511\\\",\\\"createTimestamp\\\":\\\"2021-02-10T02:32:28.295Z\\\"},\\\"control\\\":{\\\"state\\\":\\\"alarm\\\",\\\"reason\\\":\\\"Not approved\\\",\\\"details\\\":[{\\\"key\\\":\\\"Usage\\\",\\\"value\\\":\\\"Not approved\\\"},{\\\"key\\\":\\\"Regions\\\",\\\"value\\\":\\\"Approved\\\"},{\\\"key\\\":\\\"Budget\\\",\\\"value\\\":\\\"Skipped\\\"},{\\\"key\\\":\\\"RESULT\\\",\\\"value\\\":\\\"Not approved\\\"}],\\\"type\\\":{\\\"trunk\\\":{\\\"title\\\":\\\"AWS > S3 > Bucket > Approved\\\"}},\\\"turbot\\\":{\\\"id\\\":\\\"213197618618065\\\"},\\\"resource\\\":{\\\"akas\\\":[\\\"arn:aws:s3:::cf-templates-ax02xvb3xu53-us-east-2\\\"],\\\"metadata\\\":{\\\"aws\\\":{\\\"accountId\\\":\\\"210125595713\\\",\\\"partition\\\":\\\"aws\\\",\\\"regionName\\\":\\\"us-east-2\\\"},\\\"createTimestamp\\\":\\\"2021-01-09T22:33:13.000Z\\\"},\\\"title\\\":null,\\\"turbot\\\":{\\\"id\\\":\\\"213197617575590\\\"}}},\\\"oldControl\\\":{\\\"state\\\":\\\"ok\\\",\\\"turbot\\\":{\\\"id\\\":\\\"213197618618065\\\"}}}\",\n \"Timestamp\" : \"2021-02-10T02:32:31.665Z\",\n \"SignatureVersion\" : \"1\",\n \"Signature\" : \"Pj2toq70NDyx/sgggCPwi9121avVlT4y4wmqpWF/6h5/Cr+Ox+bTnRAxEvqQmhaoNesmeVs9Q97zNFLniU3X0Igfumx8hTpUKC8Yi54eyyPtUc4As9MGu6OEnvy4AQ9QMk3ZA+TnMrbT7H/D3bxz+JR1X93/vMhi3efUtdHOlfyrWTcz5yI62AxtKeJKQcwwcuu2vFzGWxM4cyst78FAzpBhGpEDa8r2H35eYbh0MHe7rDS36Evmv2oddqIfly8v3uKJdJCIJrXj4X/hi6RM7vMXD+3C3zuVkUYXl0MXtWHLjR0SFGBdGPviE9bq1y7yLinopAFOSKm67wZuHvhOxA==\",\n \"SigningCertURL\" : \"https://sns.eu-west-2.amazonaws.com/SimpleNotificationService-010a507c1833636cd94bdb98bd93083a.pem\",\n \"UnsubscribeURL\" : \"https://sns.eu-west-2.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic:b2a70670-64b3-48cb-af6a-3effb15abcfa\"\n}",
#             "attributes": {
#                 "ApproximateReceiveCount": "6",
#                 "SentTimestamp": "1612924351698",
#                 "SenderId": "AIDAIVEA3AGEU7NF6DRAG",
#                 "ApproximateFirstReceiveTimestamp": "1612924351698"
#             },
#             "messageAttributes": {},
#             "md5OfMessageAttributes": None,
#             "md5OfBody": "f0bd891e505262dadfeff5dd44284fb1",
#             "eventSource": "aws:sqs",
#             "eventSourceARN": "arn:aws:sqs:eu-west-2:210125595713:turbot-update-notification-queue",
#             "awsRegion": "eu-west-2"
#         },
#         {
#             "messageId": "b0f6e0a3-60da-4a4f-9be7-7520846e4716",
#             "receiptHandle": "AQEBLjfUQxD+4LGrhczIkB2ZZKlEGP/CtUSESqMnCYMiNgE3IHurvq3AgXZpjppim5D1carDSK/mh4hjxv66dUt9PMgDB8Kz3T/Iq6ZcJCaBeA1KCK+7zKZ+wlVoWWLVenKmEyCmU5QGoYvuxweVU0JvSDB/HBPxjjD5TnyIhNb6vp6kfRx1esIV5RXlTXRHCJX8GRhD2zp6usoHadHruOzqzVMyLnfBNWWWmDL4DPfzTIBwRub3kZYA5J4k1SwHeO3at0qpCgRkt+QkmF+aEfwizzHPs1s6Cjf542EWammSM4GuMAtAOD99+Sd+YzsutCLa0wWB+9sCb1PYeAcVW45n9hCGfxFEkUsNq8+tEeXnuCkLpuTA/D6lBYqByvpPO2xuiAaKPYxI5KXFTbSxwYaouwTtKEqDj3eGnxktnErteo0=",
#             "body": "{\n \"Type\" : \"Notification\",\n \"MessageId\" : \"cdd01589-d7a1-51f9-9b07-4d149fa1d9da\",\n \"TopicArn\" : \"arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic\",\n \"Subject\" : \"[punisher-turbot] Control Approved updated by Turbot Identity\",\n \"Message\" : \"{\\\"notificationType\\\":\\\"control_updated\\\",\\\"actor\\\":{\\\"identity\\\":{\\\"picture\\\":\\\"https://www.gravatar.com/avatar/cb9ff8606c24daf9cda1d82615bd7a8e\\\",\\\"turbot\\\":{\\\"title\\\":\\\"Turbot Identity\\\",\\\"id\\\":\\\"173249891011852\\\"}}},\\\"turbot\\\":{\\\"type\\\":null,\\\"controlId\\\":\\\"209109092294459\\\",\\\"controlOldVersionId\\\":\\\"215954570900952\\\",\\\"controlNewVersionId\\\":\\\"215954980870288\\\",\\\"createTimestamp\\\":\\\"2021-02-10T02:32:16.004Z\\\"},\\\"control\\\":{\\\"state\\\":\\\"alarm\\\",\\\"reason\\\":\\\"Not approved\\\",\\\"details\\\":[{\\\"key\\\":\\\"Usage\\\",\\\"value\\\":\\\"Not approved\\\"},{\\\"key\\\":\\\"Regions\\\",\\\"value\\\":\\\"Approved\\\"},{\\\"key\\\":\\\"Budget\\\",\\\"value\\\":\\\"Skipped\\\"},{\\\"key\\\":\\\"RESULT\\\",\\\"value\\\":\\\"Not approved\\\"}],\\\"type\\\":{\\\"trunk\\\":{\\\"title\\\":\\\"AWS > S3 > Bucket > Approved\\\"}},\\\"turbot\\\":{\\\"id\\\":\\\"209109092294459\\\"},\\\"resource\\\":{\\\"akas\\\":[\\\"arn:aws:s3:::turbot-210125595713-eu-west-1\\\"],\\\"metadata\\\":{\\\"aws\\\":{\\\"accountId\\\":\\\"210125595713\\\",\\\"partition\\\":\\\"aws\\\",\\\"regionName\\\":\\\"eu-west-1\\\"},\\\"createTimestamp\\\":\\\"2020-11-24T17:03:32.000Z\\\"},\\\"title\\\":null,\\\"turbot\\\":{\\\"id\\\":\\\"209109091524005\\\"}}},\\\"oldControl\\\":{\\\"state\\\":\\\"ok\\\",\\\"turbot\\\":{\\\"id\\\":\\\"209109092294459\\\"}}}\",\n \"Timestamp\" : \"2021-02-10T02:32:32.640Z\",\n \"SignatureVersion\" : \"1\",\n \"Signature\" : \"pnyQUQdXOjmvX+df//OsWyvdfQJTw3CrcY9EV0si9TBkWZXpXRRftkE+NCR9Dop+S0jr0L2lFpOWxsO9cEN2LwRSuQ9R+n47tETGkJaNePi9KDNV59bBlqwV5wd1r/qzRJMLb512KJQElRSmlHgpURQKcbzNge/ONESOpc4s1MC5mArZ5FO+ct2DF9cM8hvrYln6Mdv3WwSOfJb2b138clo4fUjL+uYfIc94lBHK1Qg/scdUZhi0voAqFPu4Vn9Nf0CpmDGVoLgOquy99TssDDGUnRcuR3ijm25Bf5aSBWFSnd/7Umfny9hrpWBrKIAySkX3ygD+FFXwfDqAO3rjpQ==\",\n \"SigningCertURL\" : \"https://sns.eu-west-2.amazonaws.com/SimpleNotificationService-010a507c1833636cd94bdb98bd93083a.pem\",\n \"UnsubscribeURL\" : \"https://sns.eu-west-2.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:eu-west-2:210125595713:turbot-update-notification-topic:b2a70670-64b3-48cb-af6a-3effb15abcfa\"\n}",
#             "attributes": {
#                 "ApproximateReceiveCount": "6",
#                 "SentTimestamp": "1612924352682",
#                 "SenderId": "AIDAIVEA3AGEU7NF6DRAG",
#                 "ApproximateFirstReceiveTimestamp": "1612924352682"
#             },
#             "messageAttributes": {},
#             "md5OfMessageAttributes": None,
#             "md5OfBody": "b40af5f60757ce20d565809ae2419bd4",
#             "eventSource": "aws:sqs",
#             "eventSourceARN": "arn:aws:sqs:eu-west-2:210125595713:turbot-update-notification-queue",
#             "awsRegion": "eu-west-2"
#         }
#     ]
# }


# lambda_handler(event, context)
