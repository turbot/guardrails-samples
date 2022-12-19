#-Shane Vertner 12.19.2022 
#-Goal Iterate over all users in AWS account and list out the IAM policies attached to the user

import boto3
iam = boto3.client('iam')

for user_detail in iam.get_account_authorization_details(Filter=['User'])['UserDetailList']:
 policyname = []
 policyarn = []
 # find each policy attached to the user
 for policy in user_detail['AttachedManagedPolicies']:
  policyname.append(policy['PolicyName'])
  policyarn.append(policy['PolicyArn'])
 # print user details 
 print("User: {0}\nUserID: {1}\nPolicyName: {2}\nPolicyARN: {3}\n".format(
 user_detail['UserName'],
 user_detail['UserId'],
 policyname,
 policyarn
 )
 )