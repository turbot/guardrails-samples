import boto3

# Create an IAM client
iam = boto3.client('iam')

# Get a list of all IAM users in the account
response = iam.list_users()

# Iterate over each user
for user in response['Users']:
    # Get the user's policies
    response = iam.list_attached_user_policies(UserName=user['UserName'])
    policies = response['AttachedPolicies']
    while response['IsTruncated']:
        response = iam.list_attached_user_policies(UserName=user['UserName'], Marker=response['Marker'])
        policies += response['AttachedPolicies']

    # Print the policies for the user
    print(f"Policies for user {user['UserName']}:")
    for policy in policies:
        print(policy['PolicyName'])
