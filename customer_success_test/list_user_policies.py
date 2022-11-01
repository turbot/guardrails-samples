import boto3
client = boto3.client('iam',aws_access_key_id="XXX",aws_secret_access_key="XXX") 

for key in users['Users']:
    List_of_Policies =  client.list_user_policies(UserName=key['UserName'])
    for key in List_of_Policies['PolicyNames']:
        print key['PolicyName']
