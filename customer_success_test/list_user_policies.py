#!/opt/homebrew/bin/python3
import boto3

client = boto3.client('iam')
response = client.list_users()
users = response['Users']

for user in users:
        user_name = user['UserName']

        #Get IAM user policies via list_attached_user_policies
        iam_attached_policies = client.list_attached_user_policies(UserName=user_name)
       
        #Get the iam attached policy names
        iam_policy_name = [policy['PolicyName'] for policy in iam_attached_policies['AttachedPolicies']]
    
        #print users and their attached IAM policies 
        print ("AWS User: ",user_name, " has the following attached policies ", iam_policy_name)
        
